# 🚀 Quick Start - 3 Passos

## 1. Subir tudo de uma vez

```bash
cd expense-manager
docker-compose up -d
```

Aguarde 60 segundos para inicialização completa.

## 2. Acessar a aplicação

Abra: **http://localhost:3000**

## 3. Fazer login

Use uma das contas pré-criadas:

- **Usuário:** `admin` | **Senha:** `admin123`
- **Usuário:** `demo` | **Senha:** `demo123`

---

## ✨ O que foi configurado automaticamente?

✅ Banco PostgreSQL  
✅ Keycloak com realm `expense-realm`  
✅ Clients API e Frontend configurados  
✅ 2 usuários de teste criados  
✅ Tema de login personalizado  
✅ Backend ASP.NET Core  
✅ Frontend React com Tailwind  

## 🎨 Tela de Login Personalizada

A tela de login possui:
- Design moderno com gradiente
- Cores personalizadas do Expense Manager
- Layout responsivo
- Animações suaves

## 📝 Próximos passos

1. Configure seu salário mensal e reserva
2. Adicione suas despesas
3. Acompanhe seu saldo no dashboard

## 🛠️ Comandos úteis

```bash
# Ver logs em tempo real
docker-compose logs -f

# Parar tudo
docker-compose down

# Reiniciar do zero (apaga dados)
docker-compose down -v && docker-compose up -d
```

## 🔧 Acessar admin do Keycloak

URL: http://localhost:8080  
Admin: `admin` / `admin`

---

**Pronto! Sua aplicação está rodando! 🎉**
