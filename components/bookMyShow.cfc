<cfcomponent>
    <cffunction name="fetchDetails" access="remote" returntype="any">
        <cfargument name="phone" type="string" required="true">
        <cfset result = {}>

            <cfquery name="qryfetchDetails">
                SELECT name,role_id,mail,phone
                FROM
                tb_user
                WHERE
                phone = <cfqueryparam value="#arguments.phone#" cfsqltype="CF_SQL_VARCHAR">
            </cfquery>
                <cfif qryfetchDetails.recordCount gt 0>
                    <!-- Access the role_id from the first row of the query result -->
                    <cfset roleId = qryfetchDetails.role_id[1]> 
                    <cfset result.name = qryfetchDetails.name[1]>
                    <cfset result.mail = qryfetchDetails.mail[1]>
                    <cfset result.phone = qryfetchDetails.phone[1]>
                    <cfquery name="qryFetchRole">
                        SELECT  role
                        FROM
                        tb_role
                        WHERE
                        role_id = <cfqueryparam value="#roleId#" cfsqltype="CF_SQL_INTEGER">
                    </cfquery>  
                    <cfif qryFetchRole.recordCount gt 0>
                        <cfset result.role = qryFetchRole.role[1]> 
                    </cfif> 
                </cfif>
            <cfreturn result>
    </cffunction>


    <cffunction name="insertUser" access="remote" returntype="any">
        <cfargument name="name" type="string" required="true">
        <cfargument name="mail" type="string" required="true">
        <cfargument name="phone" type="string" required="true">
        <cfset roleId=2>

        <cfquery name="qryInsertUser">

            INSERT
            INTO tb_user
            (name,mail,phone,role_id)
            VALUES
            (
                <cfqueryparam value="#arguments.name#" cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value="#arguments.mail#" cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value="#arguments.phone#" cfsqltype="CF_SQL_VARCHAR">,               
                <cfqueryparam value="#roleId#" cfsqltype="CF_SQL_INTEGER">

                    
            )
        

        </cfquery>

        <cfreturn roleId>
    </cffunction>




</cfcomponent>