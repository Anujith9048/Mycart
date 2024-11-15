<cfif structKeyExists(url, "sort")>
  <cfif structKeyExists(url, "subid")>
    <cfset variable.data ='#url.subid#'>
    <cfset variable.mode ='sub'>
    <cfset local.productslist = application.getlistObj.getProductsSorted(url.subid,url.sort)>
    <cfset local.subcategoryName =application.getlistObj.getSubcategoryName(#url.subid#)>
    <cfset local.subcategory = local.subcategoryName.category.FLDSUBCATEGORYNAME>
    <cfelse>
      <cfset variable.mode ='search'>
      <cfset variable.data ='#url.search#'>
      <cfset local.productslist = application.getlistObj.searchProductSorted(url.search,url.sort)>
      <cfset local.subcategory = "Showing result for #url.search#">
  </cfif>
  <cfelse>
    <cfif structKeyExists(url, "subid")>
      <cfset variable.data ='#url.subid#'>
      <cfset variable.mode ='sub'>
      <cfset local.productslist = application.getlistObj.getProducts(url.subid)>
      <cfset local.subcategoryName =application.getlistObj.getSubcategoryName(#url.subid#)>
      <cfset local.subcategory = local.subcategoryName.category.FLDSUBCATEGORYNAME>
      <cfelse>
        <cfset variable.mode ='search'>
        <cfset variable.data ='#url.search#'>
        <cfset local.productslist = application.getlistObj.searchProduct(url.search)>
        <cfset local.subcategory = "Showing result for #url.search#">
    </cfif>
</cfif>