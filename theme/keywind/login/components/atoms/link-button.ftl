<#macro kw color="" component="a" size="" class="" rest...>
  <#switch color>
    <#case "primary">
      <#assign colorClass="bg-primary-600 hover:bg-primary-400 text-white focus:ring-primary-600 hover:bg-primary-700">
      <#break>
    <#case "secondary">
      <#assign colorClass="bg-gray-600 hover:bg-gray-400 text-white focus:ring-gray-600 hover:bg-gray-700">
      <#break>
    <#case "outline-secondary">
      <#assign colorClass="text-gray-600 hover:text-gray-400 focus:ring-gray-600 hover:text-gray-700 border border-gray-600">
      <#break>
    <#default>
      <#assign colorClass="bg-primary-600 hover:bg-primary-400 text-white focus:ring-primary-600 hover:bg-primary-700">
  </#switch>

  <#switch size>
    <#case "small">
      <#assign sizeClass="text-sm">
      <#break>
    <#default>
      <#assign sizeClass="">
  </#switch>

  <${component}
    class="<#compress>${colorClass} ${sizeClass} w-full inline-flex px-4 py-2 text-sm flex justify-center relative rounded-lg w-full focus:outline-none focus:ring-2 focus:ring-offset-2 ${class}</#compress>"

    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </${component}>
</#macro>
