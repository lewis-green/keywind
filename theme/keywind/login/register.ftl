<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>
<#import "components/atoms/link.ftl" as link>
<#import "user-profile-commons.ftl" as userProfileCommons>
<#import "register-commons.ftl" as registerCommons>

<@layout.registrationLayout
  displayMessage=!messagesPerField.existsError("firstName", "lastName", "email", "username", "password", "password-confirm")
  ;
  section
>
  <#if section="header">
    ${msg("registerTitle")}
  <#elseif section="form">
    <@form.kw action=url.registrationAction method="post">
      <@userProfileCommons.userProfileFormFields; callback, attribute>
        <#if callback = "afterField">
            <#-- render password fields just under the username or email (if used as username) -->
            <#if passwordRequired?? && (attribute.name == 'username' || (attribute.name == 'email' && realm.registrationEmailAsUsername))>
              <div>
                <label for="password" class="block text-sm font-medium leading-6 text-gray-900">${msg("password")}</label>
                <div class="mt-2">
                  <input type="password" id="password" name="password" value="" class="block w-full rounded-md border-0 py-1.5 shadow-sm ring-1 ring-inset placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-sky-600 sm:text-sm sm:leading-6 <#if messagesPerField.existsError('password')>ring-red-500 text-red-700<#else>ring-gray-300 text-gray-900 </#if>" aria-invalid="" autocomplete="password">

                  <#if messagesPerField.existsError('password')>
                    <p class="mt-2 text-sm text-red-600" id="input-error-password" aria-live="polite">
                      ${kcSanitize(messagesPerField.get('password'))?no_esc}
                    </p>
                  </#if>
                </div>
              </div>
              <div>
                <label for="password-confirm" class="block text-sm font-medium leading-6 text-gray-900">${msg("passwordConfirm")}</label>
                <div class="mt-2">
                  <input type="password" id="password-confirm" name="password-confirm" value="" class="block w-full rounded-md border-0 py-1.5 shadow-sm ring-1 ring-inset placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-sky-600 sm:text-sm sm:leading-6 <#if messagesPerField.existsError('password-confirm')>ring-red-500 text-red-700<#else>ring-gray-300 text-gray-900 </#if>" aria-invalid="" autocomplete="password">

                  <#if messagesPerField.existsError('password-confirm')>
                    <p class="mt-2 text-sm text-red-600" id="input-error-password" aria-live="polite">
                      ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                    </p>
                  </#if>
                </div>
              </div>
            </#if>
        </#if>
      </@userProfileCommons.userProfileFormFields>

      <@registerCommons.termsAcceptance/>
      <#if recaptchaRequired??>
        <div class="g-recaptcha" data-sitekey="${recaptchaSiteKey}" data-size="compact"></div>
      </#if>
      <@buttonGroup.kw>
        <@button.kw color="primary" type="submit">
          ${msg("doRegister")}
        </@button.kw>
      </@buttonGroup.kw>
    </@form.kw>
  <#elseif section="nav">
    <@link.kw color="secondary" href=url.loginUrl size="small">
      ${kcSanitize(msg("backToLogin"))?no_esc}
    </@link.kw>
  </#if>
</@layout.registrationLayout>
