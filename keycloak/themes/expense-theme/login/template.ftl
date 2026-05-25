<!DOCTYPE html>
<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false showAnotherWayIfPresent=true>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="robots" content="noindex, nofollow" />
    <title>Gerenciador de Gastos</title>
    <link rel="stylesheet" href="${url.resourcesPath}/css/login.css" />
</head>
<body>

<div class="page">
  <div class="card">

    <div class="card-header">
      <div class="brand-icon">💰</div>
      <h1 class="brand-title">Gerenciador de Gastos</h1>
      <p class="brand-sub">Controle suas finanças com inteligência</p>
    </div>

    <div class="card-body">

      <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
        <div class="alert alert-${message.type}">
          <#if message.type = 'error'>
            <svg class="alert-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/>
            </svg>
          <#elseif message.type = 'success'>
            <svg class="alert-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <circle cx="12" cy="12" r="10"/><polyline points="9 12 11 14 15 10"/>
            </svg>
          </#if>
          <span>${kcSanitize(message.summary)?no_esc}</span>
        </div>
      </#if>

      <#nested "form">
    </div>

    <#if displayInfo>
    <div class="card-footer">
      <#nested "info">
    </div>
    </#if>

  </div>
</div>

</body>
</html>
</#macro>
