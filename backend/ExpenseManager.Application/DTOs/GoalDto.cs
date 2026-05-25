namespace ExpenseManager.Application.DTOs;

public record GoalDto(
    Guid Id,
    string Title,
    string? Description,
    decimal TargetAmount,
    decimal CurrentAmount,
    string Category,
    string? Deadline,
    bool IsCompleted,
    DateTime CreatedAt,
    DateTime UpdatedAt
);

public record CreateGoalDto(
    string Title,
    decimal TargetAmount,
    string Category = "Outro",
    string? Description = null,
    string? Deadline = null
);

public record UpdateGoalDto(
    string Title,
    decimal TargetAmount,
    string Category,
    string? Description = null,
    string? Deadline = null
);

public record ContributeDto(decimal Amount);
