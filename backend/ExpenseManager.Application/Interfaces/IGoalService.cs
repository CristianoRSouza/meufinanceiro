using ExpenseManager.Application.DTOs;

namespace ExpenseManager.Application.Interfaces;

public interface IGoalService
{
    Task<IEnumerable<GoalDto>> GetGoalsByUserAsync(string keycloakId);
    Task<GoalDto> CreateGoalAsync(string keycloakId, CreateGoalDto dto);
    Task<GoalDto> UpdateGoalAsync(string keycloakId, Guid goalId, UpdateGoalDto dto);
    Task DeleteGoalAsync(string keycloakId, Guid goalId);
    Task<GoalDto> ContributeAsync(string keycloakId, Guid goalId, decimal amount);
    Task<GoalDto> WithdrawAsync(string keycloakId, Guid goalId, decimal amount);
}
