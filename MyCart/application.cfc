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
    <cffunction name="onError" returntype="void">
        <cfargument name="exception" required="true">
        <cfargument name="eventName" required="true">
        
        <cfset var developerEmail = "developerMycart@gmail.com">
        <cfmail 
            to="#developerEmail#" 
            from="Mycart@gmail.com" 
            subject="Application Error in #this.name#">
            An error occurred in the application:
            <br><br>
            <strong>Error Message:</strong> #arguments.exception.message#
            <br>
            <strong>Error In:</strong>
             Path : #arguments.EXCEPTION.TagContext[1].TEMPLATE#
            <br> Line: #arguments.EXCEPTION.TagContext[1].LINE#
            <br>
            <strong>Detail:</strong> #arguments.exception.detail#
            <br>
        </cfmail>        
        <cflocation  url="errorpage.cfm">
        <cfabort>
    </cffunction>
</cfcomponent>
