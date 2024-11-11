<cfcomponent>
    <!--- Application settings --->
    <cfset this.name = "MyCartApplication">
    <cfset this.sessionManagement = true>
    <cfset this.setClientCookies = true>
    <cfset this.datasource = "sqlDatabase">
    
    <!--- Session start event --->
    <cffunction name="onSessionStart" returntype="void">
        <cfset session.isLog = false>
        <cfset session.username = "">
        <cfset session.userId = "">
        <cfset session.role = "">
    </cffunction>

    <!--- Application start event --->
    <cffunction name="onApplicationStart" returntype="void" access="public">
        <cfset application.getlistObj = createObject("component", "models.getList")>
    </cffunction>

    <!--- Error handling --->
    
</cfcomponent>
