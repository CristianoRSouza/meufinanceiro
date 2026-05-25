using ExpenseManager.Application.Interfaces;
using ExpenseManager.Application.Services;
using ExpenseManager.Domain.Interfaces;
using ExpenseManager.Infrastructure.Data;
using ExpenseManager.Infrastructure.Repositories;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

var builder = WebApplication.CreateBuilder(args);

// ── Connection string ────────────────────────────────────────────────────────
// Railway provides DATABASE_URL (postgresql://user:pass@host:port/db).
// Local docker-compose uses ConnectionStrings__DefaultConnection.
static string ResolveConnectionString(IConfiguration config)
{
    var url = Environment.GetEnvironmentVariable("DATABASE_URL");
    if (!string.IsNullOrEmpty(url))
    {
        var uri   = new Uri(url);
        var parts = uri.UserInfo.Split(':', 2);
        var user  = Uri.UnescapeDataString(parts[0]);
        var pass  = parts.Length > 1 ? Uri.UnescapeDataString(parts[1]) : "";
        var port  = uri.Port > 0 ? uri.Port : 5432;
        var db    = uri.AbsolutePath.TrimStart('/');
        return $"Host={uri.Host};Port={port};Database={db};Username={user};Password={pass};SSL Mode=Require;Trust Server Certificate=true";
    }
    return config.GetConnectionString("DefaultConnection")
           ?? throw new InvalidOperationException("No database connection string configured.");
}

// Database
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseNpgsql(ResolveConnectionString(builder.Configuration)));

// Repositories
builder.Services.AddScoped<IUnitOfWork, UnitOfWork>();

// Services
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<IExpenseService, ExpenseService>();
builder.Services.AddScoped<IGoalService, GoalService>();

// ── Authentication ───────────────────────────────────────────────────────────
// Railway: set KEYCLOAK_AUTHORITY env var.
// Local:   Keycloak__Authority in docker-compose environment block.
var keycloakAuthority =
    Environment.GetEnvironmentVariable("KEYCLOAK_AUTHORITY")
    ?? builder.Configuration["Keycloak:Authority"];

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.Authority = keycloakAuthority;
        options.Audience  = builder.Configuration["Keycloak:Audience"];
        options.RequireHttpsMetadata = false;
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer   = true,
            ValidateAudience = false,
            ValidateLifetime = true,
        };
    });

builder.Services.AddAuthorization();

// ── CORS ─────────────────────────────────────────────────────────────────────
// Railway: set ALLOWED_ORIGINS=https://your-frontend.up.railway.app
// Local:   defaults to http://localhost:3000
var allowedOrigins = (
    Environment.GetEnvironmentVariable("ALLOWED_ORIGINS")
    ?? "http://localhost:3000"
).Split(',', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries);

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowFrontend", policy =>
    {
        policy.WithOrigins(allowedOrigins)
              .AllowAnyHeader()
              .AllowAnyMethod()
              .AllowCredentials();
    });
});

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// ── Bootstrap tables ─────────────────────────────────────────────────────────
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
    db.Database.ExecuteSqlRaw("""
        CREATE TABLE IF NOT EXISTS "Users" (
            "Id"              uuid         NOT NULL PRIMARY KEY,
            "KeycloakId"      varchar(255) NOT NULL,
            "Email"           varchar(255) NOT NULL,
            "MonthlySalary"   numeric(18,2) NOT NULL DEFAULT 0,
            "ReservedAmount"  numeric(18,2) NOT NULL DEFAULT 0,
            "CreatedAt"       timestamptz  NOT NULL DEFAULT now(),
            "UpdatedAt"       timestamptz  NOT NULL DEFAULT now()
        );
        CREATE UNIQUE INDEX IF NOT EXISTS "IX_Users_KeycloakId" ON "Users" ("KeycloakId");

        CREATE TABLE IF NOT EXISTS "Expenses" (
            "Id"          uuid         NOT NULL PRIMARY KEY,
            "UserId"      uuid         NOT NULL,
            "Description" varchar(500) NOT NULL,
            "Amount"      numeric(18,2) NOT NULL DEFAULT 0,
            "Category"    varchar(100) NOT NULL DEFAULT 'Outros',
            "DueDate"     timestamptz  NOT NULL,
            "IsPaid"      boolean      NOT NULL DEFAULT false,
            "PaidAt"      timestamptz,
            "CreatedAt"   timestamptz  NOT NULL DEFAULT now(),
            "UpdatedAt"   timestamptz  NOT NULL DEFAULT now(),
            CONSTRAINT "FK_Expenses_Users_UserId"
                FOREIGN KEY ("UserId") REFERENCES "Users" ("Id") ON DELETE CASCADE
        );
        CREATE INDEX IF NOT EXISTS "IX_Expenses_UserId" ON "Expenses" ("UserId");
        ALTER TABLE "Expenses" ADD COLUMN IF NOT EXISTS "Category" varchar(100) NOT NULL DEFAULT 'Outros';

        ALTER TABLE "Users" ADD COLUMN IF NOT EXISTS "Nome"           varchar(100);
        ALTER TABLE "Users" ADD COLUMN IF NOT EXISTS "Sobrenome"      varchar(100);
        ALTER TABLE "Users" ADD COLUMN IF NOT EXISTS "Apelido"        varchar(100);
        ALTER TABLE "Users" ADD COLUMN IF NOT EXISTS "Telefone"       varchar(20);
        ALTER TABLE "Users" ADD COLUMN IF NOT EXISTS "DataNascimento" varchar(10);
        ALTER TABLE "Users" ADD COLUMN IF NOT EXISTS "Cpf"            varchar(14);
        ALTER TABLE "Users" ADD COLUMN IF NOT EXISTS "Ocupacao"       varchar(200);
        ALTER TABLE "Users" ADD COLUMN IF NOT EXISTS "Genero"         varchar(50);

        CREATE TABLE IF NOT EXISTS "Goals" (
            "Id"            uuid          NOT NULL PRIMARY KEY,
            "UserId"        uuid          NOT NULL,
            "Title"         varchar(200)  NOT NULL,
            "Description"   varchar(500),
            "TargetAmount"  numeric(18,2) NOT NULL DEFAULT 0,
            "CurrentAmount" numeric(18,2) NOT NULL DEFAULT 0,
            "Category"      varchar(50)   NOT NULL DEFAULT 'Outro',
            "Deadline"      varchar(10),
            "CreatedAt"     timestamptz   NOT NULL DEFAULT now(),
            "UpdatedAt"     timestamptz   NOT NULL DEFAULT now(),
            CONSTRAINT "FK_Goals_Users_UserId"
                FOREIGN KEY ("UserId") REFERENCES "Users" ("Id") ON DELETE CASCADE
        );
        CREATE INDEX IF NOT EXISTS "IX_Goals_UserId" ON "Goals" ("UserId");
    """);
}

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors("AllowFrontend");
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();

app.Run();
