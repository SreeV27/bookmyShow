<cfcomponent>
    <cfset this.name = "Book My Show">
    <cfset this.sessionManagement = true>
    <cfset this.sessionTimeout = CreateTimeSpan(0 ,0,1,0)> 
    <cfset this.datasource = "mydb">
    
    
    <cffunction name="onSessionStart" returnType="boolean">        
        <cfset session.userId=0>
        <cfset session.userName="">
        <cfreturn true>
    </cffunction>

    <cffunction name="onRequestStart" access="public" returntype="boolean" >
        <cfargument name="targetPage" type="string" required="false">
        
        <cfif  (!StructKeyExists(session, "userId") || session.userId EQ 0) && arguments.targetPage NEQ '/bookmyShow/body.cfm' >
            <cflocation url="body.cfm" >
        </cfif>
        <cfreturn true> 
    </cffunction>
    

</cfcomponent>


