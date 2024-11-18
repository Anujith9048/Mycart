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

    <!--- Request start event --->
    <cffunction name="onRequestStart" returntype="void" access="public">
        <cfif structKeyExists(url, "reload") AND url.reload EQ "1">
            <cfset onApplicationStart()>
        </cfif>
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
            
            Error Message: #arguments.exception.message#
            
            Error In:
            Path : #arguments.EXCEPTION.TagContext[1].TEMPLATE#
            Line: #arguments.EXCEPTION.TagContext[1].LINE#
            
            Detail: #arguments.exception.detail#
            
        </cfmail>        
        <cflocation  url="errorpage.cfm" addtoken="no">
        <cfabort>
    </cffunction>
</cfcomponent>
