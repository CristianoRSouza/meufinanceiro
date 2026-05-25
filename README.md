# Expense Manager

Sistema de gerenciamento de gastos pessoais com React, ASP.NET Core, Keycloak e PostgreSQL.

## Arquitetura

### Backend (ASP.NET Core 8.0)
- **Domain**: Entidades e interfaces
- **Application**: Serviços e DTOs
- **Infrastructure**: Repositórios, UnitOfWork e DbContext
- **API**: Controllers e configuração

### Frontend (React 18 + TypeScript)
- **Tailwind CSS 4**: Estilização
- **Keycloak**: Autenticação
- **Axios**: Comunicação com API
- **React Router**: Navegação

## Pré-requisitos

- Docker e Docker Compose
- .NET 8.0 SDK (para desenvolvimento local)
- Node.js 20+ (para desenvolvimento local)

## Configuração do Keycloak

1. Acesse http://localhost:8080
2. Login: admin / admin
3. Crie um realm chamado `expense-realm`
4. Crie um client `expense-api`:
   - Client Protocol: openid-connect
   - Access Type: bearer-only
5. Crie um client `expense-frontend`:
   - Client Protocol: openid-connect
   - Access Type: public
   - Valid Redirect URIs: http://localhost:3000/*
   - Web Origins: http://localhost:3000
6. Crie usuários no realm

**OU simplesmente execute `docker-compose up` - tudo será configurado automaticamente!**

O Keycloak já vem pré-configurado com:
- Realm `expense-realm` criado
- Clients `expense-api` e `expense-frontend` configurados
- Usuários: `admin/admin123` e `demo/demo123`
- Tema de login personalizado

## Executar com Docker Compose

```bash
cd expense-manager
docker-compose up --build
```

Serviços disponíveis:
- Frontend: http://localhost:3000
- Backend API: http://localhost:5000
- Keycloak: http://localhost:8080
- PostgreSQL: localhost:5432

## Desenvolvimento Local

### Backend

```bash
cd backend/ExpenseManager.Api
dotnet restore
dotnet ef migrations add InitialCreate --project ../ExpenseManager.Infrastructure
dotnet ef database update --project ../ExpenseManager.Infrastructure
dotnet run
```

### Frontend

```bash
cd frontend
npm install
npm start
```

## Funcionalidades

- ✅ Autenticação com Keycloak
- ✅ Cadastro de salário mensal e reserva
- ✅ Cadastro de despesas
- ✅ Marcar despesas como pagas
- ✅ Dashboard com resumo financeiro
- ✅ Cálculo de saldo disponível
- ✅ Separação de camadas (SOLID)
- ✅ Repository Pattern
- ✅ Unit of Work Pattern
- ✅ Entity Framework Core
- ✅ PostgreSQL

## Estrutura do Projeto

```
expense-manager/
├── backend/
│   ├── ExpenseManager.Api/          # Controllers e configuração
│   ├── ExpenseManager.Application/  # Serviços e DTOs
│   ├── ExpenseManager.Domain/       # Entidades e interfaces
│   └── ExpenseManager.Infrastructure/ # Repositórios e DbContext
├── frontend/
│   └── src/
│       ├── components/              # Componentes React
│       ├── pages/                   # Páginas
│       ├── api.ts                   # Cliente API
│       └── keycloak.ts              # Configuração Keycloak
└── docker-compose.yml
```

## Tecnologias

- **Backend**: ASP.NET Core 8.0, Entity Framework Core, PostgreSQL
- **Frontend**: React 18, TypeScript, Tailwind CSS 4
- **Autenticação**: Keycloak 23
- **Containerização**: Docker, Docker Compose
