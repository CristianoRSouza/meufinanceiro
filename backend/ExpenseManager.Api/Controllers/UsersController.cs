using ExpenseManager.Application.DTOs;
using ExpenseManager.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace ExpenseManager.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class UsersController : ControllerBase
{
    private readonly IUserService _userService;

    public UsersController(IUserService userService)
    {
        _userService = userService;
    }

    private string GetKeycloakId() => User.FindFirst(ClaimTypes.NameIdentifier)?.Value 
        ?? User.FindFirst("sub")?.Value 
        ?? throw new UnauthorizedAccessException();

    [HttpGet("me")]
    public async Task<ActionResult<UserDto>> GetCurrentUser()
    {
        var keycloakId = GetKeycloakId();
        var user = await _userService.GetUserByKeycloakIdAsync(keycloakId);
        return user == null ? NotFound() : Ok(user);
    }

    [HttpPost]
    public async Task<ActionResult<UserDto>> CreateUser([FromBody] CreateUserDto dto)
    {
        var keycloakId = GetKeycloakId();
        var user = await _userService.CreateUserAsync(keycloakId, dto);
        return CreatedAtAction(nameof(GetCurrentUser), user);
    }

    [HttpPut]
    public async Task<ActionResult<UserDto>> UpdateUser([FromBody] UpdateUserDto dto)
    {
        var keycloakId = GetKeycloakId();
        var user = await _userService.UpdateUserAsync(keycloakId, dto);
        return Ok(user);
    }
}
