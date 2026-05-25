using ExpenseManager.Application.DTOs;

namespace ExpenseManager.Application.Interfaces;

public interface IExpenseService
{
    Task<IEnumerable<ExpenseDto>> GetUserExpensesAsync(string keycloakId);
    Task<ExpenseDto> CreateExpenseAsync(string keycloakId, CreateExpenseDto dto);
    Task<ExpenseDto> UpdateExpenseAsync(string keycloakId, Guid expenseId, UpdateExpenseDto dto);
    Task DeleteExpenseAsync(string keycloakId, Guid expenseId);
    Task<ExpenseDto> MarkAsPaidAsync(string keycloakId, Guid expenseId);
    Task<DashboardDto> GetDashboardAsync(string keycloakId);
}
