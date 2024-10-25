<cfcomponent>
<!---  Check User  --->
  <cffunction name="checkUser" access="remote" returnformat="JSON">
    <cfargument name="username" type="string" >
    <cfargument name="email" type="string" >
    <cfargument name="password" type="string" >

    <cfquery name="check" datasource="sqlDatabase" result="checkResult">
      SELECT fldUser_ID,fldUserName,fldRoleID FROM tbluserlogin 
      WHERE fldEmail = <cfqueryparam value="#arguments.email#"  cfsqltype="cf_sql_varchar">;
    </cfquery>
    <cfif check.recordCount>
      <cfreturn {"result":true,"msg":check}>

      <cfelse>
        <cfreturn {"result":false,"msg":"newAccount"}>
    </cfif>
  </cffunction>

<!--- Login User --->
  <cffunction name="logUser" access="remote" returnformat="JSON">
    <cfargument name="username" type="string" >
    <cfargument name="email" type="string" >
    <cfargument name="password" type="string" >

    <cfquery name="fetchRoleId" datasource="sqlDatabase" result="checkResult">
      SELECT fldrole_ID FROM tblroleslist
      WHERE fldroleName = <cfqueryparam value="Admin" cfsqltype="cf_sql_varchar">;
    </cfquery>
    
    <cfquery name="createAccount" datasource="sqlDatabase" result="newAccount">
      INSERT INTO tbluserlogin (fldUserName,fldEmail,fldPassword,fldRoleID) 
      VALUES(
        <cfqueryparam value="#arguments.username#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#arguments.password#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#fetchRoleId.fldrole_ID#" cfsqltype="cf_sql_varchar">
      );
    </cfquery>
    <cfset local.newUserId = newAccount.generatedKey>
    <cfreturn {"result":true,"userId":local.newUserId}>
  </cffunction>

<!---  Logout user  --->
<cffunction name="logout" access="remote" returnformat="JSON">
  <cfset StructClear(session)>  
  <cfreturn true>
</cffunction>
</cfcomponent>