using ExpenseManager.Application.DTOs;
using ExpenseManager.Application.Interfaces;
using ExpenseManager.Domain.Entities;
using ExpenseManager.Domain.Interfaces;

namespace ExpenseManager.Application.Services;

public class GoalService : IGoalService
{
    private readonly IUnitOfWork _unitOfWork;

    public GoalService(IUnitOfWork unitOfWork)
    {
        _unitOfWork = unitOfWork;
    }

    private async Task<User> GetUserByKeycloakIdAsync(string keycloakId)
    {
        var users = await _unitOfWork.Repository<User>().FindAsync(u => u.KeycloakId == keycloakId);
        return users.FirstOrDefault() ?? throw new Exception("User not found");
    }

    private static GoalDto ToDto(Goal g) => new(
        g.Id, g.Title, g.Description, g.TargetAmount, g.CurrentAmount,
        g.Category, g.Deadline, g.CurrentAmount >= g.TargetAmount,
        g.CreatedAt, g.UpdatedAt
    );

    public async Task<IEnumerable<GoalDto>> GetGoalsByUserAsync(string keycloakId)
    {
        var user = await GetUserByKeycloakIdAsync(keycloakId);
        var goals = await _unitOfWork.Repository<Goal>().FindAsync(g => g.UserId == user.Id);
        return goals.OrderByDescending(g => g.CreatedAt).Select(ToDto);
    }

    public async Task<GoalDto> CreateGoalAsync(string keycloakId, CreateGoalDto dto)
    {
        var user = await GetUserByKeycloakIdAsync(keycloakId);
        var goal = new Goal
        {
            Id = Guid.NewGuid(),
            UserId = user.Id,
            Title = dto.Title,
            Description = dto.Description,
            TargetAmount = dto.TargetAmount,
            CurrentAmount = 0,
            Category = dto.Category,
            Deadline = dto.Deadline,
            CreatedAt = DateTime.UtcNow,
            UpdatedAt = DateTime.UtcNow
        };
        await _unitOfWork.Repository<Goal>().AddAsync(goal);
        await _unitOfWork.SaveChangesAsync();
        return ToDto(goal);
    }

    public async Task<GoalDto> UpdateGoalAsync(string keycloakId, Guid goalId, UpdateGoalDto dto)
    {
        var user = await GetUserByKeycloakIdAsync(keycloakId);
        var goal = await _unitOfWork.Repository<Goal>().GetByIdAsync(goalId)
            ?? throw new Exception("Goal not found");
        if (goal.UserId != user.Id) throw new UnauthorizedAccessException();

        goal.Title = dto.Title;
        goal.Description = dto.Description;
        goal.TargetAmount = dto.TargetAmount;
        goal.Category = dto.Category;
        goal.Deadline = dto.Deadline;
        goal.UpdatedAt = DateTime.UtcNow;

        _unitOfWork.Repository<Goal>().Update(goal);
        await _unitOfWork.SaveChangesAsync();
        return ToDto(goal);
    }

    public async Task DeleteGoalAsync(string keycloakId, Guid goalId)
    {
        var user = await GetUserByKeycloakIdAsync(keycloakId);
        var goal = await _unitOfWork.Repository<Goal>().GetByIdAsync(goalId)
            ?? throw new Exception("Goal not found");
        if (goal.UserId != user.Id) throw new UnauthorizedAccessException();

        _unitOfWork.Repository<Goal>().Delete(goal);
        await _unitOfWork.SaveChangesAsync();
    }

    public async Task<GoalDto> ContributeAsync(string keycloakId, Guid goalId, decimal amount)
    {
        var user = await GetUserByKeycloakIdAsync(keycloakId);
        var goal = await _unitOfWork.Repository<Goal>().GetByIdAsync(goalId)
            ?? throw new Exception("Goal not found");
        if (goal.UserId != user.Id) throw new UnauthorizedAccessException();

        goal.CurrentAmount = Math.Min(goal.CurrentAmount + amount, goal.TargetAmount);
        goal.UpdatedAt = DateTime.UtcNow;

        _unitOfWork.Repository<Goal>().Update(goal);
        await _unitOfWork.SaveChangesAsync();
        return ToDto(goal);
    }

    public async Task<GoalDto> WithdrawAsync(string keycloakId, Guid goalId, decimal amount)
    {
        var user = await GetUserByKeycloakIdAsync(keycloakId);
        var goal = await _unitOfWork.Repository<Goal>().GetByIdAsync(goalId)
            ?? throw new Exception("Goal not found");
        if (goal.UserId != user.Id) throw new UnauthorizedAccessException();

        goal.CurrentAmount = Math.Max(0, goal.CurrentAmount - amount);
        goal.UpdatedAt = DateTime.UtcNow;

        _unitOfWork.Repository<Goal>().Update(goal);
        await _unitOfWork.SaveChangesAsync();
        return ToDto(goal);
    }
}
