FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["ExpenseManager.Api/ExpenseManager.Api.csproj", "ExpenseManager.Api/"]
COPY ["ExpenseManager.Application/ExpenseManager.Application.csproj", "ExpenseManager.Application/"]
COPY ["ExpenseManager.Domain/ExpenseManager.Domain.csproj", "ExpenseManager.Domain/"]
COPY ["ExpenseManager.Infrastructure/ExpenseManager.Infrastructure.csproj", "ExpenseManager.Infrastructure/"]
RUN dotnet restore "ExpenseManager.Api/ExpenseManager.Api.csproj"
COPY . .
WORKDIR "/src/ExpenseManager.Api"
RUN dotnet build "ExpenseManager.Api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ExpenseManager.Api.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ExpenseManager.Api.dll"]
