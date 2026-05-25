using ExpenseManager.Application.DTOs;
using ExpenseManager.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace ExpenseManager.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class GoalsController : ControllerBase
{
    private readonly IGoalService _goalService;

    public GoalsController(IGoalService goalService)
    {
        _goalService = goalService;
    }

    private string GetKeycloakId() =>
        User.FindFirst(ClaimTypes.NameIdentifier)?.Value ??
        User.FindFirst("sub")?.Value ??
        throw new UnauthorizedAccessException();

    private static readonly string[] GoalCategories =
        ["Viagem", "Moradia", "Veículo", "Tecnologia", "Educação", "Saúde", "Casamento", "Emergência", "Lazer", "Negócio", "Outro"];

    [HttpGet("categories")]
    public ActionResult<IEnumerable<string>> GetCategories() => Ok(GoalCategories);

    [HttpGet]
    public async Task<ActionResult<IEnumerable<GoalDto>>> GetGoals()
    {
        var goals = await _goalService.GetGoalsByUserAsync(GetKeycloakId());
        return Ok(goals);
    }

    [HttpPost]
    public async Task<ActionResult<GoalDto>> CreateGoal([FromBody] CreateGoalDto dto)
    {
        var goal = await _goalService.CreateGoalAsync(GetKeycloakId(), dto);
        return CreatedAtAction(nameof(GetGoals), goal);
    }

    [HttpPut("{id:guid}")]
    public async Task<ActionResult<GoalDto>> UpdateGoal(Guid id, [FromBody] UpdateGoalDto dto)
    {
        try
        {
            var goal = await _goalService.UpdateGoalAsync(GetKeycloakId(), id, dto);
            return Ok(goal);
        }
        catch (UnauthorizedAccessException) { return Forbid(); }
        catch (Exception e) { return NotFound(e.Message); }
    }

    [HttpDelete("{id:guid}")]
    public async Task<IActionResult> DeleteGoal(Guid id)
    {
        try { await _goalService.DeleteGoalAsync(GetKeycloakId(), id); return NoContent(); }
        catch (UnauthorizedAccessException) { return Forbid(); }
        catch (Exception e) { return NotFound(e.Message); }
    }

    [HttpPost("{id:guid}/contribute")]
    public async Task<ActionResult<GoalDto>> Contribute(Guid id, [FromBody] ContributeDto dto)
    {
        try
        {
            var goal = await _goalService.ContributeAsync(GetKeycloakId(), id, dto.Amount);
            return Ok(goal);
        }
        catch (UnauthorizedAccessException) { return Forbid(); }
        catch (Exception e) { return NotFound(e.Message); }
    }

    [HttpPost("{id:guid}/withdraw")]
    public async Task<ActionResult<GoalDto>> Withdraw(Guid id, [FromBody] ContributeDto dto)
    {
        try
        {
            var goal = await _goalService.WithdrawAsync(GetKeycloakId(), id, dto.Amount);
            return Ok(goal);
        }
        catch (UnauthorizedAccessException) { return Forbid(); }
        catch (Exception e) { return NotFound(e.Message); }
    }
}
