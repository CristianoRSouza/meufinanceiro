using ExpenseManager.Application.DTOs;
using ExpenseManager.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace ExpenseManager.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class ExpensesController : ControllerBase
{
    private readonly IExpenseService _expenseService;

    public ExpensesController(IExpenseService expenseService)
    {
        _expenseService = expenseService;
    }

    private string GetKeycloakId() => User.FindFirst(ClaimTypes.NameIdentifier)?.Value 
        ?? User.FindFirst("sub")?.Value 
        ?? throw new UnauthorizedAccessException();

    private static readonly string[] ExpenseCategories =
        ["Contas", "Alimentação", "Transporte", "Moradia", "Saúde", "Educação", "Lazer", "Outros"];

    [HttpGet("categories")]
    public ActionResult<IEnumerable<string>> GetCategories() => Ok(ExpenseCategories);

    [HttpGet]
    public async Task<ActionResult<IEnumerable<ExpenseDto>>> GetExpenses()
    {
        var keycloakId = GetKeycloakId();
        var expenses = await _expenseService.GetUserExpensesAsync(keycloakId);
        return Ok(expenses);
    }

    [HttpGet("dashboard")]
    public async Task<ActionResult<DashboardDto>> GetDashboard()
    {
        var keycloakId = GetKeycloakId();
        var dashboard = await _expenseService.GetDashboardAsync(keycloakId);
        return Ok(dashboard);
    }

    [HttpPost]
    public async Task<ActionResult<ExpenseDto>> CreateExpense([FromBody] CreateExpenseDto dto)
    {
        var keycloakId = GetKeycloakId();
        var expense = await _expenseService.CreateExpenseAsync(keycloakId, dto);
        return CreatedAtAction(nameof(GetExpenses), expense);
    }

    [HttpPut("{id}")]
    public async Task<ActionResult<ExpenseDto>> UpdateExpense(Guid id, [FromBody] UpdateExpenseDto dto)
    {
        var keycloakId = GetKeycloakId();
        var expense = await _expenseService.UpdateExpenseAsync(keycloakId, id, dto);
        return Ok(expense);
    }

    [HttpPost("{id}/pay")]
    public async Task<ActionResult<ExpenseDto>> MarkAsPaid(Guid id)
    {
        var keycloakId = GetKeycloakId();
        var expense = await _expenseService.MarkAsPaidAsync(keycloakId, id);
        return Ok(expense);
    }

    [HttpDelete("{id}")]
    public async Task<ActionResult> DeleteExpense(Guid id)
    {
        var keycloakId = GetKeycloakId();
        await _expenseService.DeleteExpenseAsync(keycloakId, id);
        return NoContent();
    }
}
