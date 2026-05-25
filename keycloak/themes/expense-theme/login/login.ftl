<#import "template.ftl" as layout>
<@layout.registrationLayout
    displayMessage=!messagesPerField.existsError('username','password')
    displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??;
    section>

  <#if section = "form">

  <form id="kc-form-login"
        action="${url.loginAction}" method="post"
        onsubmit="document.getElementById('kc-login').disabled=true; return true;">

    <div class="field">
      <label for="username">
        <#if !realm.loginWithEmailAllowed>
          ${msg("username")}
        <#elseif !realm.registrationEmailAsUsername>
          ${msg("usernameOrEmail")}
        <#else>
          E-mail
        </#if>
      </label>
      <input id="username" name="username" type="text"
             value="${(login.username!'')}"
             autofocus autocomplete="off"
             placeholder="seu@email.com"
             tabindex="1"
             class="<#if messagesPerField.existsError('username','password')>is-error</#if>" />
    </div>

    <div class="field">
      <div class="field-top">
        <label for="password">Senha</label>
        <#if realm.resetPasswordAllowed>
          <a href="${url.loginResetCredentialsUrl}" class="link-forgot" tabindex="5">
            Esqueci a senha
          </a>
        </#if>
      </div>
      <input id="password" name="password" type="password"
             autocomplete="off"
             placeholder="••••••••"
             tabindex="2"
             class="<#if messagesPerField.existsError('username','password')>is-error</#if>" />
    </div>

    <#if realm.rememberMe && !usernameEditDisabled??>
    <div class="remember">
      <label>
        <input id="rememberMe" name="rememberMe" type="checkbox"
               tabindex="3" <#if login.rememberMe??>checked</#if> />
        Lembrar de mim
      </label>
    </div>
    </#if>

    <input type="hidden" name="credentialId"
           <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if> />

    <button id="kc-login" type="submit" tabindex="4">
      Entrar na conta
    </button>

  </form>

  <#elseif section = "info">

    <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
    <div class="register-row">
      <span>Novo por aqui?</span>
      <a href="${url.registrationUrl}" tabindex="6">Criar conta grátis</a>
    </div>
    </#if>

  </#if>

</@layout.registrationLayout>
