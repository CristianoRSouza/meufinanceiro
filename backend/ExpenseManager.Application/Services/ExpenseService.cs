using System.Globalization;
using ExpenseManager.Application.DTOs;
using ExpenseManager.Application.Interfaces;
using ExpenseManager.Domain.Entities;
using ExpenseManager.Domain.Interfaces;

namespace ExpenseManager.Application.Services;

public class ExpenseService : IExpenseService
{
    private readonly IUnitOfWork _unitOfWork;

    public ExpenseService(IUnitOfWork unitOfWork)
    {
        _unitOfWork = unitOfWork;
    }

    private async Task<User> GetUserByKeycloakIdAsync(string keycloakId)
    {
        var users = await _unitOfWork.Repository<User>().FindAsync(u => u.KeycloakId == keycloakId);
        return users.FirstOrDefault() ?? throw new Exception("User not found");
    }

    private static DateTime ToUtc(DateTime dt) =>
        dt.Kind == DateTimeKind.Unspecified ? DateTime.SpecifyKind(dt, DateTimeKind.Utc) : dt.ToUniversalTime();

    private static DateTime GetSalaryPeriodStart(int salaryDay, DateTime now)
    {
        var day = Math.Clamp(salaryDay, 1, 28);
        if (now.Day >= day)
            return new DateTime(now.Year, now.Month, day, 0, 0, 0, DateTimeKind.Utc);

        var prev = now.AddMonths(-1);
        var maxDay = DateTime.DaysInMonth(prev.Year, prev.Month);
        return new DateTime(prev.Year, prev.Month, Math.Min(day, maxDay), 0, 0, 0, DateTimeKind.Utc);
    }

    public async Task<IEnumerable<ExpenseDto>> GetUserExpensesAsync(string keycloakId)
    {
        var user = await GetUserByKeycloakIdAsync(keycloakId);
        var periodStart = GetSalaryPeriodStart(user.SalaryDay, DateTime.UtcNow);
        var expenses = await _unitOfWork.Repository<Expense>().FindAsync(
            e => e.UserId == user.Id && e.DueDate >= periodStart);
        return expenses.Select(e => new ExpenseDto(e.Id, e.Description, e.Amount, e.Category, e.DueDate, e.IsPaid, e.PaidAt));
    }

    public async Task<ExpenseDto> CreateExpenseAsync(string keycloakId, CreateExpenseDto dto)
    {
        var user = await GetUserByKeycloakIdAsync(keycloakId);

        var expense = new Expense
        {
            Id = Guid.NewGuid(),
            UserId = user.Id,
            Description = dto.Description,
            Amount = dto.Amount,
            Category = dto.Category,
            DueDate = ToUtc(dto.DueDate),
            IsPaid = false,
            CreatedAt = DateTime.UtcNow,
            UpdatedAt = DateTime.UtcNow
        };

        await _unitOfWork.Repository<Expense>().AddAsync(expense);
        await _unitOfWork.SaveChangesAsync();

        return new ExpenseDto(expense.Id, expense.Description, expense.Amount, expense.Category, expense.DueDate, expense.IsPaid, expense.PaidAt);
    }

    public async Task<ExpenseDto> UpdateExpenseAsync(string keycloakId, Guid expenseId, UpdateExpenseDto dto)
    {
        var user = await GetUserByKeycloakIdAsync(keycloakId);
        var expense = await _unitOfWork.Repository<Expense>().GetByIdAsync(expenseId) 
            ?? throw new Exception("Expense not found");

        if (expense.UserId != user.Id)
            throw new UnauthorizedAccessException("Not authorized");

        expense.Description = dto.Description;
        expense.Amount = dto.Amount;
        expense.Category = dto.Category;
        expense.DueDate = ToUtc(dto.DueDate);
        expense.IsPaid = dto.IsPaid;
        expense.UpdatedAt = DateTime.UtcNow;

        _unitOfWork.Repository<Expense>().Update(expense);
        await _unitOfWork.SaveChangesAsync();

        return new ExpenseDto(expense.Id, expense.Description, expense.Amount, expense.Category, expense.DueDate, expense.IsPaid, expense.PaidAt);
    }

    public async Task DeleteExpenseAsync(string keycloakId, Guid expenseId)
    {
        var user = await GetUserByKeycloakIdAsync(keycloakId);
        var expense = await _unitOfWork.Repository<Expense>().GetByIdAsync(expenseId) 
            ?? throw new Exception("Expense not found");

        if (expense.UserId != user.Id)
            throw new UnauthorizedAccessException("Not authorized");

        _unitOfWork.Repository<Expense>().Delete(expense);
        await _unitOfWork.SaveChangesAsync();
    }

    public async Task<ExpenseDto> MarkAsPaidAsync(string keycloakId, Guid expenseId)
    {
        var user = await GetUserByKeycloakIdAsync(keycloakId);
        var expense = await _unitOfWork.Repository<Expense>().GetByIdAsync(expenseId) 
            ?? throw new Exception("Expense not found");

        if (expense.UserId != user.Id)
            throw new UnauthorizedAccessException("Not authorized");

        expense.IsPaid = true;
        expense.PaidAt = DateTime.UtcNow;
        expense.UpdatedAt = DateTime.UtcNow;

        _unitOfWork.Repository<Expense>().Update(expense);
        await _unitOfWork.SaveChangesAsync();

        return new ExpenseDto(expense.Id, expense.Description, expense.Amount, expense.Category, expense.DueDate, expense.IsPaid, expense.PaidAt);
    }

    public async Task<DashboardDto> GetDashboardAsync(string keycloakId)
    {
        var users = await _unitOfWork.Repository<User>().FindAsync(u => u.KeycloakId == keycloakId);
        var user = users.FirstOrDefault();

        if (user == null)
            return new DashboardDto(0, 0, 0, 0, 0, 0, new List<CategorySummaryDto>(), new List<ExpenseDto>(), new List<MonthlyTotalDto>());

        var now = DateTime.UtcNow;
        var periodStart = GetSalaryPeriodStart(user.SalaryDay, now);

        var expenses = await _unitOfWork.Repository<Expense>().FindAsync(
            e => e.UserId == user.Id && e.DueDate >= periodStart);
        var expenseList = expenses.ToList();

        var totalExpenses = expenseList.Sum(e => e.Amount);
        var paidExpenses = expenseList.Where(e => e.IsPaid).Sum(e => e.Amount);
        var pendingExpenses = expenseList.Where(e => !e.IsPaid).Sum(e => e.Amount);
        var availableBalance = user.MonthlySalary - totalExpenses;

        var categorySummaries = expenseList
            .GroupBy(e => e.Category)
            .Select(g => new CategorySummaryDto(g.Key, g.Sum(e => e.Amount)))
            .OrderByDescending(c => c.Total)
            .ToList();

        var expenseDtos = expenseList
            .Select(e => new ExpenseDto(e.Id, e.Description, e.Amount, e.Category, e.DueDate, e.IsPaid, e.PaidAt))
            .ToList();

        var ptBR = new CultureInfo("pt-BR");
        var monthlyTotals = Enumerable.Range(0, 6)
            .Select(i =>
            {
                var d = new DateTime(now.Year, now.Month, 1, 0, 0, 0, DateTimeKind.Utc).AddMonths(-(5 - i));
                var total = expenseList
                    .Where(e => e.DueDate.Year == d.Year && e.DueDate.Month == d.Month)
                    .Sum(e => e.Amount);
                var abbr = d.ToString("MMM", ptBR);
                var label = char.ToUpperInvariant(abbr[0]) + abbr[1..];
                return new MonthlyTotalDto(label, d.Year, total);
            })
            .ToList();

        return new DashboardDto(
            user.MonthlySalary,
            user.ReservedAmount,
            totalExpenses,
            paidExpenses,
            pendingExpenses,
            availableBalance,
            categorySummaries,
            expenseDtos,
            monthlyTotals
        );
    }
}
