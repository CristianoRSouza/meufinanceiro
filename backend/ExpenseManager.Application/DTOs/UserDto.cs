namespace ExpenseManager.Application.DTOs;

public record UserDto(
    Guid Id,
    string Email,
    decimal MonthlySalary,
    decimal ReservedAmount,
    int SalaryDay,
    string? Nome,
    string? Sobrenome,
    string? Apelido,
    string? Telefone,
    string? DataNascimento,
    string? Cpf,
    string? Ocupacao,
    string? Genero
);

public record CreateUserDto(
    string Email,
    decimal MonthlySalary,
    decimal ReservedAmount,
    int SalaryDay = 1,
    string? Nome = null,
    string? Sobrenome = null,
    string? Apelido = null,
    string? Telefone = null,
    string? DataNascimento = null,
    string? Cpf = null,
    string? Ocupacao = null,
    string? Genero = null
);

public record UpdateUserDto(
    decimal MonthlySalary,
    decimal ReservedAmount,
    int SalaryDay = 1,
    string? Nome = null,
    string? Sobrenome = null,
    string? Apelido = null,
    string? Telefone = null,
    string? DataNascimento = null,
    string? Cpf = null,
    string? Ocupacao = null,
    string? Genero = null
);
