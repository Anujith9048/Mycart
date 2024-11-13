<cfset local.getlistObj = createObject("component", "models.getlist")>
<cfif structKeyExists(url, "sort")>
  <cfif structKeyExists(url, "subid")>
    <cfset variable.data ='#url.subid#'>
    <cfset variable.mode ='sub'>
    <cfset local.productslist = local.getlistObj.getProductsSorted(url.subid,url.sort)>
    <cfset local.subcategoryName =local.getlistObj.getSubcategoryName(#url.subid#)>
    <cfset local.subcategory = local.subcategoryName.category.FLDSUBCATEGORYNAME>
    <cfelse>
      <cfset variable.mode ='search'>
      <cfset variable.data ='#url.search#'>
      <cfset local.productslist = local.getlistObj.searchProductSorted(url.search,url.sort)>
      <cfset local.subcategory = "Showing result for #url.search#">
  </cfif>
  <cfelse>
    <cfif structKeyExists(url, "subid")>
      <cfset variable.data ='#url.subid#'>
      <cfset variable.mode ='sub'>
      <cfset local.productslist = local.getlistObj.getProducts(url.subid)>
      <cfset local.subcategoryName =local.getlistObj.getSubcategoryName(#url.subid#)>
      <cfset local.subcategory = local.subcategoryName.category.FLDSUBCATEGORYNAME>
      <cfelse>
        <cfset variable.mode ='search'>
        <cfset variable.data ='#url.search#'>
        <cfset local.productslist = local.getlistObj.searchProduct(url.search)>
        <cfset local.subcategory = "Showing result for #url.search#">
    </cfif>
</cfif>