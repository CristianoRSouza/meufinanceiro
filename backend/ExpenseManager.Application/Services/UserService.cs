using ExpenseManager.Application.DTOs;
using ExpenseManager.Application.Interfaces;
using ExpenseManager.Domain.Entities;
using ExpenseManager.Domain.Interfaces;

namespace ExpenseManager.Application.Services;

public class UserService : IUserService
{
    private readonly IUnitOfWork _unitOfWork;

    public UserService(IUnitOfWork unitOfWork)
    {
        _unitOfWork = unitOfWork;
    }

    private static UserDto ToDto(User u) => new(
        u.Id, u.Email, u.MonthlySalary, u.ReservedAmount, u.SalaryDay,
        u.Nome, u.Sobrenome, u.Apelido, u.Telefone,
        u.DataNascimento, u.Cpf, u.Ocupacao, u.Genero
    );

    public async Task<UserDto?> GetUserByKeycloakIdAsync(string keycloakId)
    {
        var users = await _unitOfWork.Repository<User>().FindAsync(u => u.KeycloakId == keycloakId);
        var user = users.FirstOrDefault();
        return user == null ? null : ToDto(user);
    }

    public async Task<UserDto> CreateUserAsync(string keycloakId, CreateUserDto dto)
    {
        var user = new User
        {
            Id = Guid.NewGuid(),
            KeycloakId = keycloakId,
            Email = dto.Email,
            MonthlySalary = dto.MonthlySalary,
            ReservedAmount = dto.ReservedAmount,
            SalaryDay = Math.Clamp(dto.SalaryDay, 1, 28),
            Nome = dto.Nome,
            Sobrenome = dto.Sobrenome,
            Apelido = dto.Apelido,
            Telefone = dto.Telefone,
            DataNascimento = dto.DataNascimento,
            Cpf = dto.Cpf,
            Ocupacao = dto.Ocupacao,
            Genero = dto.Genero,
            CreatedAt = DateTime.UtcNow,
            UpdatedAt = DateTime.UtcNow
        };

        await _unitOfWork.Repository<User>().AddAsync(user);
        await _unitOfWork.SaveChangesAsync();

        return ToDto(user);
    }

    public async Task<UserDto> UpdateUserAsync(string keycloakId, UpdateUserDto dto)
    {
        var users = await _unitOfWork.Repository<User>().FindAsync(u => u.KeycloakId == keycloakId);
        var user = users.FirstOrDefault() ?? throw new Exception("User not found");

        user.MonthlySalary = dto.MonthlySalary;
        user.ReservedAmount = dto.ReservedAmount;
        user.SalaryDay = Math.Clamp(dto.SalaryDay, 1, 28);
        user.Nome = dto.Nome;
        user.Sobrenome = dto.Sobrenome;
        user.Apelido = dto.Apelido;
        user.Telefone = dto.Telefone;
        user.DataNascimento = dto.DataNascimento;
        user.Cpf = dto.Cpf;
        user.Ocupacao = dto.Ocupacao;
        user.Genero = dto.Genero;
        user.UpdatedAt = DateTime.UtcNow;

        _unitOfWork.Repository<User>().Update(user);
        await _unitOfWork.SaveChangesAsync();

        return ToDto(user);
    }
}
