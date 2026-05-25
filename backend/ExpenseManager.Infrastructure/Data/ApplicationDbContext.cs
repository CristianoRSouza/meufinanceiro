using ExpenseManager.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace ExpenseManager.Infrastructure.Data;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

    public DbSet<User> Users { get; set; }
    public DbSet<Expense> Expenses { get; set; }
    public DbSet<Goal> Goals { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Email).IsRequired().HasMaxLength(255);
            entity.Property(e => e.KeycloakId).IsRequired().HasMaxLength(255);
            entity.Property(e => e.MonthlySalary).HasPrecision(18, 2);
            entity.Property(e => e.ReservedAmount).HasPrecision(18, 2);
            entity.Property(e => e.Nome).HasMaxLength(100);
            entity.Property(e => e.Sobrenome).HasMaxLength(100);
            entity.Property(e => e.Apelido).HasMaxLength(100);
            entity.Property(e => e.Telefone).HasMaxLength(20);
            entity.Property(e => e.DataNascimento).HasMaxLength(10);
            entity.Property(e => e.Cpf).HasMaxLength(14);
            entity.Property(e => e.Ocupacao).HasMaxLength(200);
            entity.Property(e => e.Genero).HasMaxLength(50);
            entity.HasIndex(e => e.KeycloakId).IsUnique();
        });

        modelBuilder.Entity<Expense>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Description).IsRequired().HasMaxLength(500);
            entity.Property(e => e.Amount).HasPrecision(18, 2);
            entity.Property(e => e.Category).HasMaxLength(100).HasDefaultValue("Outros");
            entity.HasOne(e => e.User)
                  .WithMany(u => u.Expenses)
                  .HasForeignKey(e => e.UserId)
                  .OnDelete(DeleteBehavior.Cascade);
        });

        modelBuilder.Entity<Goal>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Title).IsRequired().HasMaxLength(200);
            entity.Property(e => e.Description).HasMaxLength(500);
            entity.Property(e => e.TargetAmount).HasPrecision(18, 2);
            entity.Property(e => e.CurrentAmount).HasPrecision(18, 2);
            entity.Property(e => e.Category).HasMaxLength(50).HasDefaultValue("Outro");
            entity.Property(e => e.Deadline).HasMaxLength(10);
            entity.HasOne(e => e.User)
                  .WithMany(u => u.Goals)
                  .HasForeignKey(e => e.UserId)
                  .OnDelete(DeleteBehavior.Cascade);
        });
    }
}
