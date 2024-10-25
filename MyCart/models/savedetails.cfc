<cfcomponent>

    <!--- Check category --->
<cffunction name="checkCategory" access="remote" returnformat="JSON">
    <cfargument name="categoryName" type="string" >
    <cfquery name="checkCategoryList" datasource="sqlDatabase" result="checkResult">
      SELECT 1 FROM tblcategories 
      WHERE fldCategory_name = <cfqueryparam value="#arguments.categoryName#"  cfsqltype="cf_sql_varchar">;
    </cfquery>
    <cfreturn {"result":checkResult}>
  </cffunction>

<!--- Add Category --->
  <cffunction name="addCategory" access="remote" returnformat="JSON">
    <cfargument name="categoryName" type="string" >
        <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
        <cfquery name="addCategoryList" datasource="sqlDatabase" result="addResult">
            INSERT INTO tblcategories (fldCategory_name,fldCreatedBy,fldCreatedDate)
            VALUES(
                <cfqueryparam value="#arguments.categoryName#"  cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#session.userID#"  cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">
            );
          </cfquery>
      <cfreturn {"result":true}>
  </cffunction>

  <!--- Edit Category --->
  <cffunction name="editCategory" access="remote" returnformat="JSON">
    <cfargument name="categoryName" type="string" >
    <cfargument name="id" type="string" >
        <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
        <cfquery name="editCategoryList" datasource="sqlDatabase" result="editResult">
            UPDATE tblcategories
            SET fldCategory_name =  <cfqueryparam value="#arguments.categoryName#"  cfsqltype="cf_sql_varchar">,
                fldEditedBy =  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_varchar">,
                fldEditedDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">
            WHERE fldCategory_ID =  <cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_varchar">;
          </cfquery>
      <cfreturn {"result":true}>
  </cffunction>

  <!--- Delete Categories --->
  <cffunction name="deleteCategories" access="remote" returnformat="JSON">
    <cfargument name="id" type="string" >
        <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
        <cfquery name="editCategoryList" datasource="sqlDatabase" result="editResult">
            UPDATE tblcategories
            SET
                fldDeactivatedBy =  <cfqueryparam value="#session.userId#"  cfsqltype="cf_sql_varchar">,
                fldDeactivatedDate =  <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">,
                fldActive = <cfqueryparam value="0"  cfsqltype="cf_sql_varchar">
            WHERE fldCategory_ID =  <cfqueryparam value="#arguments.id#"  cfsqltype="cf_sql_varchar">;
          </cfquery>
      <cfreturn {"result":true}>
  </cffunction>

  <!--- Check category --->
  <cffunction name="getCategoryID" access="remote" returnformat="JSON">
    <cfargument name="categoryName" type="string" >
    <cfquery name="checkCategoryList" datasource="sqlDatabase" result="id">
      SELECT fldCategory_ID FROM tblcategories 
      WHERE fldCategory_name = <cfqueryparam value="#arguments.categoryName#"  cfsqltype="cf_sql_varchar">;
    </cfquery>
    <cfreturn {"result":checkCategoryList}>
  </cffunction>

  <!--- Add SubCategory --->
  <cffunction name="addSubcategory" access="remote" returnformat="JSON">
    <cfargument name="subCategoryName" type="string" >
    <cfargument name="categoryID" type="string" >
        <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
        <cfquery name="addCategoryList" datasource="sqlDatabase" result="addResult">
            INSERT INTO tblsubcategories (fldSubcategoryName,fldCreatedBy,fldCategoryID,fldCreatedDate)
            VALUES(
                <cfqueryparam value="#arguments.subCategoryName#"  cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#session.userID#"  cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.categoryID#"  cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#local.currentDate#"  cfsqltype="cf_sql_varchar">
            );
          </cfquery>
      <cfreturn {"result":true}>
  </cffunction>
</cfcomponent>
