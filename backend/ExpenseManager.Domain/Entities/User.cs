namespace ExpenseManager.Domain.Entities;

public class User
{
    public Guid Id { get; set; }
    public string KeycloakId { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public decimal MonthlySalary { get; set; }
    public decimal ReservedAmount { get; set; }
    public int SalaryDay { get; set; } = 1;

    // Personal info
    public string? Nome { get; set; }
    public string? Sobrenome { get; set; }
    public string? Apelido { get; set; }
    public string? Telefone { get; set; }
    public string? DataNascimento { get; set; }
    public string? Cpf { get; set; }
    public string? Ocupacao { get; set; }
    public string? Genero { get; set; }

    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }

    public ICollection<Expense> Expenses { get; set; } = new List<Expense>();
    public ICollection<Goal> Goals { get; set; } = new List<Goal>();
}
