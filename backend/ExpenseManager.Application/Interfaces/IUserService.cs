using ExpenseManager.Application.DTOs;

namespace ExpenseManager.Application.Interfaces;

public interface IUserService
{
    Task<UserDto?> GetUserByKeycloakIdAsync(string keycloakId);
    Task<UserDto> CreateUserAsync(string keycloakId, CreateUserDto dto);
    Task<UserDto> UpdateUserAsync(string keycloakId, UpdateUserDto dto);
}
