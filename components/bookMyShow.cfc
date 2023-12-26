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
                <cfif qryfetchDetails.recordCount>
                    <!-- Access the role_id from the first row of the query result -->
                    <cfset session.userId=qryfetchDetails.user_id[1]>
                    <cfset session.userName= qryfetchDetails.name[1]>
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
                    <cfif qryFetchRole.recordCount>
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
        <cfif qryUserExists.recordCount>
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
        <cfset StructClear(Session)>
    </cffunction>

    <cffunction  name="fetchAllMovieDetails" acess="public" returntype="query">  
        <cfquery name="qryFetchAllMovieDetails">
            SELECT
                tb_movie.movie_id as movieId,
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
                    FOR XML PATH('')), 1, 1, '') AS language,
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
        <cfreturn qryFetchAllMovieDetails>
    </cffunction>


    <cffunction  name="fetchMovieDetails" acess="public" returntype="query"> 
        <cfquery name="qryFetchMovieDetails">
            SELECT TOP 5
                tb_movie.movie_id as movieId,
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
                    FOR XML PATH('')), 1, 1, '') AS language,
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

    <cffunction  name="fetchMovieDetailsBasedOnId" access="public" returntype="query">
        <cfargument  name="movieId" >
        <cfquery name="qryFetchMovieDetailsBasedOnId">
            SELECT 
                tb_movie.movie_id as movieId,
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
                    FOR XML PATH('')), 1, 1, '') AS language,
                dimension,
                rating,
                cert_type
            FROM tb_movie
            INNER JOIN tb_movie_dimension ON tb_movie.movie_id = tb_movie_dimension.movie_id
            INNER JOIN tb_dimension ON tb_dimension.dimension_id = tb_movie_dimension.dimension_id
            INNER JOIN tb_movie_rating ON tb_movie.movie_id = tb_movie_rating.movie_id
            INNER JOIN tb_movie_cert ON tb_movie.movie_id = tb_movie_cert.movie_id
            INNER JOIN tb_certificate ON tb_movie_cert.cert_id = tb_certificate.cert_id
			WHERE tb_movie.movie_id = <cfqueryparam value="#arguments.movieId#" cfsqltype="CF_SQL_INTEGER">
            GROUP BY tb_movie.movie_id, name, release_date, duration, profile_img, cover_img, about, dimension, rating, cert_type
          
        </cfquery>
        <cfreturn qryFetchMovieDetailsBasedOnId>
    </cffunction>


    <cffunction  name="fetchEventDetails" acess="public" returntype="query">
        <cfquery name="qryFetchEventDetails"> 
            SELECT tb_event.event_id,name,duration,date,rate,profile_img,cover_img,language,category,location,venue 
            FROM tb_event 
            INNER JOIN tb_language 
            ON tb_event.lang_id = tb_language.lang_id           
            INNER JOIN tb_event_venue
            ON tb_event_venue.event_id = tb_event.event_id
            INNER JOIN tb_venue
            ON tb_event_venue.venue_id = tb_venue.venue_id
			 INNER JOIN tb_category
            ON tb_event.category_id = tb_category.category_id
        </cfquery>        
        <cfreturn qryFetchEventDetails>
    </cffunction>

    <cffunction  name="fetchEventDetailsBasedOnId" acess="public" returntype="query">
        <cfargument  name="eventId" >
        <cfquery name="qryFetchEventDetails">
            SELECT tb_event.event_id, name, duration, date, rate, profile_img, cover_img,
                   STUFF((SELECT ', ' + category
                          FROM tb_category
                          WHERE tb_event.category_id = tb_category.category_id
                          FOR XML PATH('')), 1, 2, '') AS categories,
                   STUFF((SELECT ', ' + language
                          FROM tb_language
                          WHERE tb_event.lang_id = tb_language.lang_id
                          FOR XML PATH('')), 1, 2, '') AS languages,
                   location, venue
            FROM tb_event
            INNER JOIN tb_language ON tb_event.lang_id = tb_language.lang_id
            INNER JOIN tb_event_venue ON tb_event_venue.event_id = tb_event.event_id
            INNER JOIN tb_venue ON tb_event_venue.venue_id = tb_venue.venue_id
            INNER JOIN tb_category ON tb_event.category_id = tb_category.category_id
            WHERE tb_event.event_id = <cfqueryparam value="#arguments.eventId#" cfsqltype="CF_SQL_INTEGER">
        </cfquery>
              

        <cfreturn qryFetchEventDetails>
    </cffunction>    

    <cffunction  name="fetchEventLanguages" acess="public" returntype="query">

        <cfquery name="qryFetchEventLanguages"> 
            SELECT DISTINCT language
            FROM tb_event 
            INNER JOIN tb_language 
            ON tb_event.lang_id = tb_language.lang_id            
        </cfquery>

        <cfreturn qryFetchEventLanguages>
    </cffunction>

    <cffunction  name="fetchEventCategory" acess="public" returntype="query">
        <cfquery name="qryFetchEventCategory"> 
            SELECT DISTINCT category
            FROM tb_event            
			INNER JOIN tb_category
            ON tb_event.category_id = tb_category.category_id           
        </cfquery>
        <cfreturn qryFetchEventCategory>
    </cffunction>


    <cffunction name="eventFiltering" access="remote" returntype="any">
        <cfargument name="date">
        <cfargument name="languages">
        <cfargument name="category">        
        <cfset languageArray = listToArray(arguments.languages, ",")>
        <cfset categoryArray = listToArray(arguments.category, ",")>    
        <cfset trimmedLanguages = trim(arguments.languages)>
        <cfset trimmedCategory = trim(arguments.category)>
        
        <cfif len(trimmedLanguages) && !len(trimmedCategory) && !len(date)>
            <cfquery name="qryFetchEventDetails"> 
                SELECT tb_event.event_id, name, duration, date, rate, profile_img, cover_img, language, category, location, venue 
                FROM tb_event 
                INNER JOIN tb_language ON tb_event.lang_id = tb_language.lang_id           
                INNER JOIN tb_event_venue ON tb_event_venue.event_id = tb_event.event_id
                INNER JOIN tb_venue ON tb_event_venue.venue_id = tb_venue.venue_id
                INNER JOIN tb_category ON tb_event.category_id = tb_category.category_id
                WHERE 1=1
                <cfloop list="#arguments.languages#" index="language">
                    AND tb_language.language = <cfqueryparam value="#language#" cfsqltype="CF_SQL_VARCHAR">
                </cfloop>
            </cfquery>


        <cfelseif !len(trimmedLanguages) && len(trimmedCategory) && !len(date)>
            <cfquery name="qryFetchEventDetails">
                SELECT tb_event.event_id, name, duration, date, rate, profile_img, cover_img, language, category, location, venue 
                FROM tb_event 
                INNER JOIN tb_language ON tb_event.lang_id = tb_language.lang_id           
                INNER JOIN tb_event_venue ON tb_event_venue.event_id = tb_event.event_id
                INNER JOIN tb_venue ON tb_event_venue.venue_id = tb_venue.venue_id
                INNER JOIN tb_category ON tb_event.category_id = tb_category.category_id
                WHERE 1=1
                <cfloop list="#arguments.category#" index="category">
                    AND tb_category.category = <cfqueryparam value="#category#" cfsqltype="CF_SQL_VARCHAR">
                </cfloop>
            </cfquery>           
        
        
        <cfelseif !len(trimmedLanguages) && !len(trimmedCategory) && len(date)>
            <cfquery name="qryFetchEventDetails"> 
                SELECT tb_event.event_id, name, duration, date, rate, profile_img, cover_img, language, category, location, venue 
                FROM tb_event 
                INNER JOIN tb_language ON tb_event.lang_id = tb_language.lang_id           
                INNER JOIN tb_event_venue ON tb_event_venue.event_id = tb_event.event_id
                INNER JOIN tb_venue ON tb_event_venue.venue_id = tb_venue.venue_id
                INNER JOIN tb_category ON tb_event.category_id = tb_category.category_id
                WHERE date=<cfqueryparam value="#arguments.date#" cfsqltype="cf_sql_date">
            </cfquery>

        <cfelseif len(trimmedLanguages) && len(trimmedCategory) && len(date)>
            <cfquery name="qryFetchEventDetails"> 
                SELECT tb_event.event_id, name, duration, date, rate, profile_img, cover_img, language, category, location, venue 
                FROM tb_event 
                INNER JOIN tb_language ON tb_event.lang_id = tb_language.lang_id           
                INNER JOIN tb_event_venue ON tb_event_venue.event_id = tb_event.event_id
                INNER JOIN tb_venue ON tb_event_venue.venue_id = tb_venue.venue_id
                INNER JOIN tb_category ON tb_event.category_id = tb_category.category_id
                WHERE date=<cfqueryparam value="#arguments.date#" cfsqltype="cf_sql_date">
                AND 1=1
                <cfloop list="#arguments.languages#" index="language">
                    AND tb_language.language = <cfqueryparam value="#language#" cfsqltype="CF_SQL_VARCHAR">
                </cfloop>
                <cfloop list="#arguments.category#" index="category">
                    AND tb_category.category = <cfqueryparam value="#category#" cfsqltype="CF_SQL_VARCHAR">
                </cfloop>               
            </cfquery>

        <cfelseif len(trimmedLanguages) && len(trimmedCategory) && !len(date)>
            <cfquery name="qryFetchEventDetails">
                SELECT tb_event.event_id, name, duration, date, rate, profile_img, cover_img, language, category, location, venue 
                FROM tb_event 
                INNER JOIN tb_language ON tb_event.lang_id = tb_language.lang_id           
                INNER JOIN tb_event_venue ON tb_event_venue.event_id = tb_event.event_id
                INNER JOIN tb_venue ON tb_event_venue.venue_id = tb_venue.venue_id
                INNER JOIN tb_category ON tb_event.category_id = tb_category.category_id
                WHERE 1=1
                <cfloop list="#arguments.category#" index="category">
                    AND tb_category.category = <cfqueryparam value="#category#" cfsqltype="CF_SQL_VARCHAR">
                </cfloop>
                <cfloop list="#arguments.languages#" index="language">
                    AND tb_language.language = <cfqueryparam value="#language#" cfsqltype="CF_SQL_VARCHAR">
                </cfloop>
            </cfquery>
            

        <cfelseif len(trimmedLanguages) && !len(trimmedCategory) && len(date)>
            <cfquery name="qryFetchEventDetails">
                SELECT tb_event.event_id, name, duration, date, rate, profile_img, cover_img, language, category, location, venue 
                FROM tb_event 
                INNER JOIN tb_language ON tb_event.lang_id = tb_language.lang_id           
                INNER JOIN tb_event_venue ON tb_event_venue.event_id = tb_event.event_id
                INNER JOIN tb_venue ON tb_event_venue.venue_id = tb_venue.venue_id
                INNER JOIN tb_category ON tb_event.category_id = tb_category.category_id
                WHERE date = <cfqueryparam value="#arguments.date#" cfsqltype="cf_sql_date">
                AND 1=1
                <cfloop list="#arguments.languages#" index="language">
                    AND tb_language.language = <cfqueryparam value="#language#" cfsqltype="CF_SQL_VARCHAR">
                </cfloop>
            </cfquery>
            

        <cfelseif !len(trimmedLanguages) && len(trimmedCategory) && len(date)>
            <cfquery name="qryFetchEventDetails"> 
                SELECT tb_event.event_id, name, duration, date, rate, profile_img, cover_img, language, category, location, venue 
                FROM tb_event 
                INNER JOIN tb_language ON tb_event.lang_id = tb_language.lang_id           
                INNER JOIN tb_event_venue ON tb_event_venue.event_id = tb_event.event_id
                INNER JOIN tb_venue ON tb_event_venue.venue_id = tb_venue.venue_id
                INNER JOIN tb_category ON tb_event.category_id = tb_category.category_id
                WHERE date=<cfqueryparam value="#arguments.date#" cfsqltype="cf_sql_date">
                AND 1=1
                <cfloop list="#arguments.category#" index="category">
                    AND tb_category.category = <cfqueryparam value="#category#" cfsqltype="CF_SQL_VARCHAR">
                </cfloop>
            </cfquery>

        <cfelse>
            <cfquery name="qryFetchEventDetails"> 
                SELECT tb_event.event_id,name,duration,date,rate,profile_img,cover_img,language,category,location,venue 
                FROM tb_event 
                INNER JOIN tb_language 
                ON tb_event.lang_id = tb_language.lang_id           
                INNER JOIN tb_event_venue
                ON tb_event_venue.event_id = tb_event.event_id
                INNER JOIN tb_venue
                ON tb_event_venue.venue_id = tb_venue.venue_id
                 INNER JOIN tb_category
                ON tb_event.category_id = tb_category.category_id
            </cfquery>  
        </cfif>        
        <cfreturn qryFetchEventDetails>
    </cffunction>
    


    <cffunction name="saveEventBookingDetails" access="remote" returntype="any">
        <cfargument name="eventId">
        <cfargument name="seats">
        <cfargument name="userId">        
        <cfquery name="qryEventRate">
            SELECT rate
            FROM tb_event
            WHERE tb_event.event_id = <cfqueryparam value="#arguments.eventId#" cfsqltype="CF_SQL_INTEGER">
        </cfquery>  
        <cfif qryEventRate.recordCount EQ 0>
            <cfthrow message="Event not found with ID: #arguments.eventId#" />
        </cfif>        
        <cfset local.rate = qryEventRate.rate[1]>
        <cfset local.amount = local.rate * arguments.seats>    
        <cfquery name="qrySaveEventBookingDetails">
            INSERT INTO 
            tb_event_booking (user_id, event_id, seat_count, amount)
            VALUES (
                <cfqueryparam value="#arguments.userId#" cfsqltype="CF_SQL_INTEGER">,
                <cfqueryparam value="#arguments.eventId#" cfsqltype="CF_SQL_INTEGER">,
                <cfqueryparam value="#arguments.seats#" cfsqltype="CF_SQL_INTEGER">,
                <cfqueryparam value="#local.amount#" cfsqltype="CF_SQL_INTEGER">
            )
        </cfquery>    
        <cfreturn true>
    </cffunction>
    


</cfcomponent>