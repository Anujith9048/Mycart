<cfcomponent>
    <!--- application settings --->
    <cfset this.name = "MyApplication">
    <cfset this.sessionManagement = true>
    <cfset this.setClientCookies = true>
    <cfset this.datasource = "sqlDatabase">
    
    <!--- Session start event --->
    <cffunction name="onSessionStart" returntype="void">
        <cfset session.isLog = false>
        <cfset session.username ="">
        <cfset session.userId ="">
        <cfset session.role ="">
    </cffunction>

</cfcomponent>
