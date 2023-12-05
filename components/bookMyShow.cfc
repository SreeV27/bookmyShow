<cfcomponent>
    <cffunction name="fetchDetails" access="remote" returntype="any">
        <cfargument name="phone" type="string" required="true">
        <cfset local.result = {}>

            <cfquery name="qryfetchDetails">
                SELECT name,user_id,role_id,mail,phone
                FROM
                tb_user
                WHERE
                phone = <cfqueryparam value="#arguments.phone#" cfsqltype="CF_SQL_VARCHAR">
            </cfquery>
                <cfif qryfetchDetails.recordCount gt 0>
                    <!-- Access the role_id from the first row of the query result -->
                    <cfset session.userId=qryfetchDetails.user_id[1]>
                    <cfset session.userName= "Hi "&qryfetchDetails.name[1]>
                    <cfset local.roleId = qryfetchDetails.role_id[1]> 
                    <cfset local.result.name = qryfetchDetails.name[1]>
                    <cfset local.result.mail = qryfetchDetails.mail[1]>
                    <cfset local.result.phone = qryfetchDetails.phone[1]>
                    <cfquery name="qryFetchRole">
                        SELECT  role
                        FROM
                        tb_role
                        WHERE
                        role_id = <cfqueryparam value="#local.roleId#" cfsqltype="CF_SQL_INTEGER">
                    </cfquery>  
                    <cfif qryFetchRole.recordCount gt 0>
                        <cfset local.result.role = qryFetchRole.role[1]> 
                    </cfif> 
                </cfif>
           
            <cfreturn local.result>
    </cffunction>


    <cffunction name="insertUser" access="remote" returntype="boolean">
        <cfargument name="name" type="string" required="true">
        <cfargument name="mail" type="string" required="true">
        <cfargument name="phone" type="string" required="true">
        <cfset local.roleId=2>
        

        <cfquery name="qryUserExists">
            SELECT  role_id
            FROM
            tb_user
            WHERE
            phone = <cfqueryparam value="#arguments.phone#" cfsqltype="CF_SQL_VARCHAR">
        </cfquery>  
        <cfif qryUserExists.recordCount gt 0>
           <cfreturn true> 
            <cfelse>
                <cfquery name="qryInsertUser">
                    INSERT
                    INTO tb_user
                    (name,mail,phone,role_id)
                    VALUES
                    (
                        <cfqueryparam value="#arguments.name#" cfsqltype="CF_SQL_VARCHAR">,
                        <cfqueryparam value="#arguments.mail#" cfsqltype="CF_SQL_VARCHAR">,
                        <cfqueryparam value="#arguments.phone#" cfsqltype="CF_SQL_VARCHAR">,               
                        <cfqueryparam value="#local.roleId#" cfsqltype="CF_SQL_INTEGER">
        
                            
                    )
                        
                </cfquery>
                <cfreturn false> 
        </cfif> 
       
    </cffunction>


    <cffunction  name="logout" access="remote">
        <cfset session.userId=0>
        <cfset session.userName="">
    </cffunction>




    <cffunction  name="fetchMovieDetails" acess="public" returntype="any">  


        <cfquery name="qryFetchMovieDetails">

            SELECT TOP 5
                tb_movie.movie_id,
                name,
                release_date,
                duration,
                profile_img,
                cover_img,
                about,
                STUFF((
                    SELECT '/' + genre_type
                    FROM tb_movie_genre
                    INNER JOIN tb_genre ON tb_genre.genre_id = tb_movie_genre.genre_id
                    WHERE tb_movie_genre.movie_id = tb_movie.movie_id
                    FOR XML PATH('')), 1, 1, '') AS genre,
                STUFF((
                    SELECT '/' + language
                    FROM tb_movie_language
                    INNER JOIN tb_language ON tb_language.lang_id = tb_movie_language.lang_id
                    WHERE tb_movie_language.movie_id = tb_movie.movie_id
                    FOR XML PATH('')), 1, 1, '') AS languages,
                dimension,
                rating,
                cert_type
            FROM tb_movie
            INNER JOIN tb_movie_dimension ON tb_movie.movie_id = tb_movie_dimension.movie_id
            INNER JOIN tb_dimension ON tb_dimension.dimension_id = tb_movie_dimension.dimension_id
            INNER JOIN tb_movie_rating ON tb_movie.movie_id = tb_movie_rating.movie_id
            INNER JOIN tb_movie_cert ON tb_movie.movie_id = tb_movie_cert.movie_id
            INNER JOIN tb_certificate ON tb_movie_cert.cert_id = tb_certificate.cert_id
            GROUP BY tb_movie.movie_id, name, release_date, duration, profile_img, cover_img, about, dimension, rating, cert_type
            ORDER BY tb_movie.movie_id ASC


        </cfquery>
        <cfreturn qryFetchMovieDetails>
    </cffunction>

</cfcomponent>