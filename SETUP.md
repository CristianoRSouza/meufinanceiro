# Guia de Configuração Rápida

## 1. Iniciar os containers

```bash
cd expense-manager
docker-compose up -d postgres keycloak
```

Aguarde 30 segundos para o Keycloak inicializar.

## 2. Aguardar inicialização

O Keycloak será configurado automaticamente com:
- Realm: `expense-realm`
- Usuários pré-criados:
  - **admin** / admin123
  - **demo** / demo123
- Tema personalizado aplicado

## 3. Iniciar Backend e Frontend

Aguarde 30-60 segundos para o Keycloak importar as configurações, depois:

```bash
docker-compose up -d backend frontend
```

## 4. Acessar a aplicação

Frontend: http://localhost:3000

**Usuários disponíveis:**
- Usuário: `admin` / Senha: `admin123`
- Usuário: `demo` / Senha: `demo123`

## Comandos Úteis

```bash
# Ver logs
docker-compose logs -f backend
docker-compose logs -f frontend

# Parar tudo
docker-compose down

# Parar e remover volumes
docker-compose down -v

# Reconstruir
docker-compose up --build
```

## Troubleshooting

### Backend não conecta no Keycloak
- Verifique se o realm `expense-realm` foi criado
- Verifique se o client `expense-api` existe

### Frontend não autentica
- Verifique se o client `expense-frontend` está configurado corretamente
- Verifique as URLs de redirect

### Erro de conexão com banco
- Aguarde alguns segundos para o PostgreSQL inicializar
- Execute: `docker-compose restart backend`
