<#import "components/atoms/input.ftl" as input>
<#import "components/atoms/form.ftl" as form>

<#macro userProfileFormFields>
  <div class="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
    <div class="space-y-6">
      <!--<div>
        <label for="email" class="block text-sm font-medium leading-6 text-gray-900">Email address</label>
        <div class="mt-2">
          <input id="email" name="email" type="email" autocomplete="email" required class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-sky-600 sm:text-sm sm:leading-6">
        </div>
      </div>

      <div>
        <div class="flex items-center justify-between">
          <label for="password" class="block text-sm font-medium leading-6 text-gray-900">Password</label>
          <div class="text-sm">
            <a href="#" class="font-semibold text-sky-600 hover:text-sky-500">Forgot password?</a>
          </div>
        </div>
        <div class="mt-2">
          <input id="password" name="password" type="password" autocomplete="current-password" required class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-sky-600 sm:text-sm sm:leading-6">
        </div>
      </div>

      <div>
        <button type="submit" class="flex w-full justify-center rounded-md bg-sky-500 px-3 py-1.5 text-sm font-semibold leading-6 text-white shadow-sm hover:bg-sky-400 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-sky-600">Sign in</button>
      </div>-->
	<#assign currentGroup="">

	<#list profile.attributes as attribute>

		<#assign group = (attribute.group)!"">
		<#if group != currentGroup>
			<#assign currentGroup=group>
			<#if currentGroup != "">
				<div
				<#list group.html5DataAnnotations as key, value>
					data-${key}="${value}"
				</#list>
				>

					<#assign groupDisplayHeader=group.displayHeader!"">
					<#if groupDisplayHeader != "">
						<#assign groupHeaderText=advancedMsg(groupDisplayHeader)!group>
					<#else>
						<#assign groupHeaderText=group.name!"">
					</#if>
          <div>
            <h2 label id="header-${attribute.group.name}" class="text-base font-semibold leading-7 text-gray-900">${groupHeaderText}</h2>
            <#assign groupDisplayDescription=group.displayDescription!"">
            <#if groupDisplayDescription != "">
              <#assign groupDescriptionText=advancedMsg(groupDisplayDescription)!"">
              <p id="description-${group.name}" class="mt-1 text-sm leading-6 text-gray-600">${groupDescriptionText}</p>
            </#if>
					</div>
				</div>
			</#if>
		</#if>

		<#nested "beforeField" attribute>
    <div>
        <label for="${attribute.name}" class="block text-sm font-medium leading-6 text-gray-900">${advancedMsg(attribute.displayName!'')}</label>
        <div class="mt-2">
          <#if attribute.annotations.inputHelperTextBefore??>
            <p class="mt-2 mb-2 text-sm text-gray-600" id="form-help-text-before-${attribute.name}" aria-live="polite">
              ${kcSanitize(advancedMsg(attribute.annotations.inputHelperTextBefore))?no_esc}
            </p>
          </#if>
          <@inputFieldByType attribute=attribute error=messagesPerField.existsError('${attribute.name}')/>
          <#if messagesPerField.existsError('${attribute.name}')>
            <p class="mt-2 text-sm text-red-600" id="input-error-${attribute.name}" aria-live="polite">
              ${kcSanitize(messagesPerField.get('${attribute.name}'))?no_esc}
            </p>
          </#if>
          <#if attribute.annotations.inputHelperTextAfter??>
            <p class="mt-2 mb-2 text-sm text-gray-600" id="form-help-text-after-${attribute.name}" aria-live="polite">
              ${kcSanitize(advancedMsg(attribute.annotations.inputHelperTextAfter))?no_esc}
            </p>
          </#if>
        </div>
      </div>
		<#nested "afterField" attribute>
	</#list>

    </div>
  </div>
	<#list profile.html5DataAnnotations?keys as key>
		<script type="module" src="${url.resourcesPath}/js/${key}.js"></script>
	</#list>
</#macro>

<#macro inputFieldByType attribute error>
	<#switch attribute.annotations.inputType!''>
	<#case 'textarea'>
		<@textareaTag attribute=attribute error=error/>
		<#break>
	<#case 'select'>
	<#case 'multiselect'>
		<@selectTag attribute=attribute error=error/>
		<#break>
	<#case 'select-radiobuttons'>
	<#case 'multiselect-checkboxes'>
		<@inputTagSelects attribute=attribute error=error/>
		<#break>
	<#default>
		<#if attribute.multivalued && attribute.values?has_content>
			<#list attribute.values as value>
				<@inputTag attribute=attribute value=value!'' error=error/>
			</#list>
		<#else>
			<@inputTag attribute=attribute value=attribute.value!'' error=error/>
		</#if>
	</#switch>
</#macro>

<#macro inputTag attribute value error>
<div className="relative mt-2 rounded-md shadow-sm">
	<input type="<@inputTagType attribute=attribute/>" id="${attribute.name}" name="${attribute.name}" value="${(value!'')}" class="block w-full rounded-md border-0 py-1.5 shadow-sm ring-1 ring-inset placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-sky-600 sm:text-sm sm:leading-6 <#if error>ring-red-500 text-red-700<#else>ring-gray-300 text-gray-900 </#if>"
		aria-invalid="<#if messagesPerField.existsError('${attribute.name}')>true</#if>"
		<#if attribute.readOnly>disabled</#if>
		<#if attribute.autocomplete??>autocomplete="${attribute.autocomplete}"</#if>
		<#if attribute.annotations.inputTypePlaceholder??>placeholder="${attribute.annotations.inputTypePlaceholder}"</#if>
		<#if attribute.annotations.inputTypePattern??>pattern="${attribute.annotations.inputTypePattern}"</#if>
		<#if attribute.annotations.inputTypeSize??>size="${attribute.annotations.inputTypeSize}"</#if>
		<#if attribute.annotations.inputTypeMaxlength??>maxlength="${attribute.annotations.inputTypeMaxlength}"</#if>
		<#if attribute.annotations.inputTypeMinlength??>minlength="${attribute.annotations.inputTypeMinlength}"</#if>
		<#if attribute.annotations.inputTypeMax??>max="${attribute.annotations.inputTypeMax}"</#if>
		<#if attribute.annotations.inputTypeMin??>min="${attribute.annotations.inputTypeMin}"</#if>
		<#if attribute.annotations.inputTypeStep??>step="${attribute.annotations.inputTypeStep}"</#if>
		<#if attribute.annotations.inputTypeStep??>step="${attribute.annotations.inputTypeStep}"</#if>
		<#list attribute.html5DataAnnotations as key, value>
    		data-${key}="${value}"
		</#list>
	/>
  </div>
</#macro>

<#macro inputTagType attribute>
	<#compress>
	<#if attribute.annotations.inputType??>
		<#if attribute.annotations.inputType?starts_with("html5-")>
			${attribute.annotations.inputType[6..]}
		<#else>
			${attribute.annotations.inputType}
		</#if>
	<#else>
	text
	</#if>
	</#compress>
</#macro>

<#macro textareaTag attribute error>
	<textarea id="${attribute.name}" name="${attribute.name}" class="${properties.kcInputClass!}"
		aria-invalid="<#if messagesPerField.existsError('${attribute.name}')>true</#if>"
		<#if attribute.readOnly>disabled</#if>
		<#if attribute.annotations.inputTypeCols??>cols="${attribute.annotations.inputTypeCols}"</#if>
		<#if attribute.annotations.inputTypeRows??>rows="${attribute.annotations.inputTypeRows}"</#if>
		<#if attribute.annotations.inputTypeMaxlength??>maxlength="${attribute.annotations.inputTypeMaxlength}"</#if>
	>${(attribute.value!'')}</textarea>
</#macro>

<#macro selectTag attribute error>
	<select id="${attribute.name}" name="${attribute.name}" class="${properties.kcInputClass!}"
		aria-invalid="<#if messagesPerField.existsError('${attribute.name}')>true</#if>"
		<#if attribute.readOnly>disabled</#if>
		<#if attribute.annotations.inputType=='multiselect'>multiple</#if>
		<#if attribute.annotations.inputTypeSize??>size="${attribute.annotations.inputTypeSize}"</#if>
	>
	<#if attribute.annotations.inputType=='select'>
		<option value=""></option>
	</#if>

	<#if attribute.annotations.inputOptionsFromValidation?? && attribute.validators[attribute.annotations.inputOptionsFromValidation]?? && attribute.validators[attribute.annotations.inputOptionsFromValidation].options??>
		<#assign options=attribute.validators[attribute.annotations.inputOptionsFromValidation].options>
	<#elseif attribute.validators.options?? && attribute.validators.options.options??>
		<#assign options=attribute.validators.options.options>
	<#else>
		<#assign options=[]>
	</#if>

	<#list options as option>
		<option value="${option}" <#if attribute.values?seq_contains(option)>selected</#if>><@selectOptionLabelText attribute=attribute option=option/></option>
	</#list>

	</select>
</#macro>

<#macro inputTagSelects attribute>
	<#if attribute.annotations.inputType=='select-radiobuttons'>
		<#assign inputType='radio'>
		<#assign classDiv=properties.kcInputClassRadio!>
		<#assign classInput=properties.kcInputClassRadioInput!>
		<#assign classLabel=properties.kcInputClassRadioLabel!>
	<#else>
		<#assign inputType='checkbox'>
		<#assign classDiv=properties.kcInputClassCheckbox!>
		<#assign classInput=properties.kcInputClassCheckboxInput!>
		<#assign classLabel=properties.kcInputClassCheckboxLabel!>
	</#if>

	<#if attribute.annotations.inputOptionsFromValidation?? && attribute.validators[attribute.annotations.inputOptionsFromValidation]?? && attribute.validators[attribute.annotations.inputOptionsFromValidation].options??>
		<#assign options=attribute.validators[attribute.annotations.inputOptionsFromValidation].options>
	<#elseif attribute.validators.options?? && attribute.validators.options.options??>
		<#assign options=attribute.validators.options.options>
	<#else>
		<#assign options=[]>
	</#if>

	<#list options as option>
		<div class="${classDiv}">
			<input type="${inputType}" id="${attribute.name}-${option}" name="${attribute.name}" value="${option}" class="${classInput}"
				aria-invalid="<#if messagesPerField.existsError('${attribute.name}')>true</#if>"
				<#if attribute.readOnly>disabled</#if>
				<#if attribute.values?seq_contains(option)>checked</#if>
			/>
			<label for="${attribute.name}-${option}" class="${classLabel}<#if attribute.readOnly> ${properties.kcInputClassRadioCheckboxLabelDisabled!}</#if>"><@selectOptionLabelText attribute=attribute option=option/></label>
		</div>
	</#list>
</#macro>

<#macro selectOptionLabelText attribute option>
	<#compress>
	<#if attribute.annotations.inputOptionLabels??>
		${advancedMsg(attribute.annotations.inputOptionLabels[option]!option)}
	<#else>
		<#if attribute.annotations.inputOptionLabelsI18nPrefix??>
			${msg(attribute.annotations.inputOptionLabelsI18nPrefix + '.' + option)}
		<#else>
			${option}
		</#if>
	</#if>
	</#compress>
</#macro>
