namespace ExpenseManager.Application.DTOs;

public record ExpenseDto(Guid Id, string Description, decimal Amount, string Category, DateTime DueDate, bool IsPaid, DateTime? PaidAt);

public record CreateExpenseDto(string Description, decimal Amount, string Category, DateTime DueDate);

public record UpdateExpenseDto(string Description, decimal Amount, string Category, DateTime DueDate, bool IsPaid);

public record CategorySummaryDto(string Category, decimal Total);

public record MonthlyTotalDto(string Month, int Year, decimal Total);

public record DashboardDto(
    decimal MonthlySalary,
    decimal ReservedAmount,
    decimal TotalExpenses,
    decimal PaidExpenses,
    decimal PendingExpenses,
    decimal AvailableBalance,
    List<CategorySummaryDto> CategorySummaries,
    List<ExpenseDto> Expenses,
    List<MonthlyTotalDto> MonthlyTotals
);
