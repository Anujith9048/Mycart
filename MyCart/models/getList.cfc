<cfcomponent>
    <cffunction name="getCategories" access="remote" returnFormat="JSON">
      <cfquery name="selectCategories" datasource="sqlDatabase">
          SELECT fldCategory_name ,fldCategory_ID FROM tblcategories
          WHERE fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_varchar">;
      </cfquery>
      <cfset local.categoriesArray = []>
      <cfloop query="selectCategories">
          <cfset arrayAppend(local.categoriesArray, fldcategory_name)>
      </cfloop>
      <cfreturn { "categories": selectCategories }>
    </cffunction>

    <cffunction name="selectCategoryName" access="remote" returnFormat="JSON">
        <cfargument name="id" type="any">
        <cfquery name="selectCategory" datasource="sqlDatabase">
            SELECT fldCategory_name  FROM tblcategories
            WHERE fldCategory_ID = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfreturn { "category": selectCategory }>
    </cffunction>

    <cffunction name="getSubCategories" access="remote" returnFormat="JSON">
        <cfargument name="id" type="string">
        <cfquery name="selectSubcategories" datasource="sqlDatabase" result="subcategories">
            SELECT fldSubcategoryName ,fldSubcategory_ID FROM tblsubcategories
            WHERE fldActive = <cfqueryparam value="1" cfsqltype="cf_sql_varchar">
            AND fldCategoryID = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">;
        </cfquery>
        <cfreturn { "subcategories": selectSubcategories }>
    </cffunction>
</cfcomponent>
