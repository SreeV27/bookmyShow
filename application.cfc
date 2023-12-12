<cfcomponent>
    <cfset this.name = "Book My Show">
    <cfset this.applicationTimeout = createTimeSpan( 0, 0, 1, 0 )>
    <cfset this.sessionManagement = true>
    <cfset this.sessionTimeout = CreateTimeSpan(0 ,0,1,0)> 
    <cfset this.datasource = "mydb">
    
    
    <cffunction name="onSessionStart" returnType="boolean">        
        <cfset session.userId=0>
        <cfset session.userName="">
        <cfreturn true>
    </cffunction>


    <cffunction  name="onApplicationStart"  returnType="boolean">
        <cfset application.welcome= "Hi">
        <cfset application.key=generateSecretKey('DES')>
        <cfreturn true> 

    </cffunction>

   <!--- <cffunction name="onRequestStart" access="public" returntype="boolean">
        <cfargument name="targetPage" type="string" required="false">        
        <!-- Check if it's an AJAX request -->
        <cfif NOT IsAjaxRequest()>
            <cfif (!StructKeyExists(session, "userId") || session.userId EQ 0) && arguments.targetPage NEQ '/BookmyShow/body.cfm'>
                <cflocation url="body.cfm">
            </cfif>
        </cfif>        
        <cfreturn true>
    </cffunction>
    
    <cffunction name="IsAjaxRequest" access="public" returntype="boolean">
        <cfreturn StructKeyExists(getHttpRequestData().headers, "x-requested-with") 
        AND getHttpRequestData().headers["x-requested-with"] EQ "XMLHttpRequest">
    </cffunction>--->

</cfcomponent>


