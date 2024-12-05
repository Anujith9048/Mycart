<cfset mode = structKeyExists(url, "subid") ? "sub" : "search">
<cfset data = mode EQ "sub" ? url.subid : url.search>
<cfset productslist = application.getlistObj.getProducts(
    subid = mode EQ "sub" ? url.subid : 0,
    search = mode EQ "search" ? url.search : "",
    sort = structKeyExists(url, "sort") ? url.sort : "")>
<cfif mode EQ "sub">
    <cfset subcategoryName = application.getlistObj.getSubcategoryName(url.subid)>
    <cfset title = subcategoryName.category.FLDSUBCATEGORYNAME>
<cfelse>
    <cfset title = "Showing result for &apos;#url.search#&apos;">
</cfif>