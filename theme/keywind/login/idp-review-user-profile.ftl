<#import "template.ftl" as layout>
<#import "user-profile-commons.ftl" as userProfileCommons>
<@layout.registrationLayout displayMessage=messagesPerField.exists('global') displayRequiredFields=true; section>
    <#if section = "header">
        ${msg("loginIdpReviewProfileTitle")}
    <#elseif section = "form">
        <form id="kc-idp-review-profile-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">

            <@userProfileCommons.userProfileFormFields/>

            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                    </div>
                </div>
                <div class="flex flex-col pt-4 space-y-2">
                  <input class="bg-primary-600 text-white focus:ring-primary-600 hover:bg-primary-700 px-4 py-2 text-sm flex justify-center relative rounded-lg w-full focus:outline-none focus:ring-2 focus:ring-offset-2" type="submit"  value="${msg("doSubmit")}" />
                </div>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
