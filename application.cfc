<cfcomponent>
    <cfset this.name = "Book My Show">
    <cfset this.sessionManagement = true>
    <cfset this.sessionTimeout = CreateTimeSpan(0 ,0,0,30)> 
    <cfset this.datasource = "mydb">
    
    <cffunction name="onSessionStart" returnType="boolean">
        <cfset session.userId=0>
        <cfset session.userName="">
        <cfreturn true>
    </cffunction>
   

</cfcomponent>


