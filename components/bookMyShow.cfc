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

    <cffunction  name="fetchAllMovieDetails" access="public" returntype="query">  
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

    <cffunction  name="fetchMovieDetails" access="public" returntype="query"> 
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


    <cffunction  name="fetchEventDetails" access="public" returntype="query">
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

    <cffunction  name="fetchEventDetailsBasedOnId" access="public" returntype="query">
        <cfargument  name="eventId" >
        <cfquery name="qryFetchEventDetails">
            SELECT tb_event.event_id, name, duration, date, rate,profile_img, cover_img,
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

    <cffunction  name="eventDetailsBasedOnId" access="remote" returntype="query">
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
    <cffunction  name="fetchEventLanguages" access="public" returntype="query">
        <cfquery name="qryFetchEventLanguages"> 
            SELECT  *
            FROM tb_language 
                     
        </cfquery>
        <cfreturn qryFetchEventLanguages>
    </cffunction>

    <cffunction  name="fetchLanguages" access="remote" returntype="query">
        <cfquery name="qryFetchEventLanguages"> 
            SELECT *
            FROM tb_language          
        </cfquery>
        <cfreturn qryFetchEventLanguages>
    </cffunction>

    

    <cffunction  name="fetchEventCategory" access="public" returntype="query">
        <cfquery name="qryFetchEventCategory"> 
            SELECT *
            FROM  tb_category                  
        </cfquery>
        <cfreturn qryFetchEventCategory>
    </cffunction>

    <cffunction  name="fetchCategory" access="remote" returntype="query">
        <cfquery name="qryFetchEventCategory"> 
            SELECT *
            FROM  tb_category                  
        </cfquery>
        <cfreturn qryFetchEventCategory>
    </cffunction>


    <cffunction name="eventFiltering" access="remote" returntype="query">
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
    
    <cffunction  name="theaterListBasedOnMovie" access="public">
        <cfargument  name="movieId">
        <cfquery name="qryTheaterList">
            SELECT tb_theater.id, tb_theater.name,tb_theater.address,tb_theater.location,tb_theater.phno,
                STRING_AGG(tb_theater_time.time, ',') AS times
                FROM
                tb_theater
                INNER JOIN
                tb_movie_theater ON tb_movie_theater.theater_id = tb_theater.id
                INNER JOIN
                tb_theater_time ON tb_theater.id = tb_theater_time.theater_id
                WHERE
                tb_movie_theater.movie_id = <cfqueryparam value="#arguments.movieId#" cfsqltype="CF_SQL_INTEGER">
                GROUP BY
                tb_theater.id, tb_theater.name,  tb_theater.address, tb_theater.location, tb_theater.phno;
        </cfquery>
        <cfreturn qryTheaterList>
    </cffunction>

    <cffunction  name="getSeatDetails">
        <cfquery name="qryGetSeatDetails">
            SELECT *FROM tb_seat
        </cfquery>
        <cfreturn qryGetSeatDetails>
    </cffunction>

    <cffunction  name="theaterDetailsBasedOnId" access="public">
        <cfargument  name="theaterId">
        <cfquery name="qryTheaterDetails">
          SELECT tb_theater.id, tb_theater.name,tb_theater.location,tb_theater.address,tb_theater.phno,
            STRING_AGG(tb_theater_time.time, ',') AS times
            FROM
            tb_theater               
            INNER JOIN
            tb_theater_time ON tb_theater.id = tb_theater_time.theater_id
            WHERE
            tb_theater.id =<cfqueryparam value="#arguments.theaterId#" cfsqltype="CF_SQL_INTEGER">
            GROUP BY
            tb_theater.id, tb_theater.name, tb_theater.location,tb_theater.address,tb_theater.phno        
        </cfquery>
        <cfreturn qryTheaterDetails>
    </cffunction>

    <cffunction  name="fetchTheaterDetailsBasedOnId" access="remote">
        <cfargument  name="theaterId">
        <cfquery name="qryTheaterDetails">
          SELECT tb_theater.id, tb_theater.name,tb_theater.location,tb_theater.address,tb_theater.phno,
            STRING_AGG(tb_theater_time.time, ',') AS times
            FROM
            tb_theater               
            INNER JOIN
            tb_theater_time ON tb_theater.id = tb_theater_time.theater_id
            WHERE
            tb_theater.id =<cfqueryparam value="#arguments.theaterId#" cfsqltype="CF_SQL_INTEGER">
            GROUP BY
            tb_theater.id, tb_theater.name, tb_theater.location,tb_theater.address,tb_theater.phno        
        </cfquery>
        <cfreturn qryTheaterDetails>
    </cffunction>


    <cffunction  name="movieBooking" access="remote"> 
        <cfargument  name="movieId">
        <cfargument  name="theaterId">
        <cfargument  name="userId">
        <cfargument  name="date">
        <cfargument  name="time">
        <cfargument  name="amount">
        <cfargument  name="seatsString">

        <cfquery name="qryMoviebooking">
            INSERT INTO tb_movie_booking(movieId,theaterId,userId,date,time,seats,amount)
            VALUES(
                <cfqueryparam value="#arguments.movieId#" cfsqltype="CF_SQL_INTEGER">,
                <cfqueryparam value="#arguments.theaterId#" cfsqltype="CF_SQL_INTEGER">,
                <cfqueryparam value="#arguments.userId#" cfsqltype="CF_SQL_INTEGER">,
                <cfqueryparam value="#arguments.date#" cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value="#arguments.time#" cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value="#arguments.seatsString#" cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value="#arguments.amount#" cfsqltype="CF_SQL_INTEGER">

            )
        </cfquery>
    </cffunction>


    <cffunction  name="fetchBookedSeatDetails" access="public">
        <cfargument  name="movieId">
        <cfargument  name="theaterId">
        <cfargument  name="date">
        <cfargument  name="time">
        <cfquery name="qryFetchBookedSeatDetails">
                SELECT
                    TRIM(VALUE) AS Seat
                FROM
                    tb_movie_booking
                CROSS APPLY
                    STRING_SPLIT(seats, ',')
                WHERE
                    movieId =<cfqueryparam value="#arguments.movieId#" cfsqltype="CF_SQL_INTEGER">
                    AND theaterId = <cfqueryparam value="#arguments.theaterId#" cfsqltype="CF_SQL_INTEGER">
                    AND date =<cfqueryparam value="#arguments.date#" cfsqltype="CF_SQL_VARCHAR">
                    AND time = <cfqueryparam value="#arguments.time#" cfsqltype="CF_SQL_VARCHAR">

        </cfquery>
        <cfreturn qryFetchBookedSeatDetails>
    </cffunction>

    <cffunction  name="searchValue" access="public" returntype="any">   
        <cfargument  name="value">
        <cfset local.result ={}>
        <cfquery name="qryFetchSearchMovieDetails">
            SELECT   movie_id as movieId
            FROM tb_movie
            WHERE LOWER(name)=LOWER(<cfqueryparam value="#arguments.value#" cfsqltype="CF_SQL_VARCHAR">)
        </cfquery>
        <cfif qryFetchSearchMovieDetails.recordCount>
            <cfset local.result.flag=1>
            <cfset local.result.id=qryFetchSearchMovieDetails.movieId[1]>
        </cfif>         
        
        <cfquery  name="qryFetchSearchEventDetails">
            SELECT   event_id as eventId
            FROM tb_event
            WHERE LOWER(name)=LOWER(<cfqueryparam value="#arguments.value#" cfsqltype="CF_SQL_VARCHAR">)
        </cfquery>
        <cfif qryFetchSearchEventDetails.recordCount>
            <cfset local.result.flag=2>
            <cfset local.result.id=qryFetchSearchEventDetails.eventId[1]>
        </cfif>


        <cfquery  name="qryFetchSearchTheaterDetails">
            SELECT tb_theater.id as theaterId
            FROM
            tb_theater  
            WHERE
			LOWER(name)=LOWER(<cfqueryparam value="#arguments.value#" cfsqltype="CF_SQL_VARCHAR">)           
        </cfquery>
        <cfif qryFetchSearchTheaterDetails.recordCount>
            <cfset local.result.flag=3>
            <cfset local.result.id=qryFetchSearchTheaterDetails.theaterId[1]>
        </cfif>

        <cfreturn local.result>  
    </cffunction>


    <cffunction  name="theaterDetails" access="public" returntype="query">
        <cfargument  name="theaterId">
        <cfquery name="qryTheaterDetails">  
            SELECT 
                tb_theater.id as theaterId,tb_movie.movie_id AS movieId,tb_movie.name as movieName,tb_theater.name,tb_theater.address,
                STRING_AGG(language, '/')  AS language,
                dimension, cert_type,tb_theater.location
                FROM tb_theater
                inner join tb_movie_theater on tb_movie_theater.theater_id = tb_theater.id
                inner join tb_movie on tb_movie.movie_id = tb_movie_theater.movie_id
                INNER JOIN tb_movie_language ON tb_movie.movie_id = tb_movie_language.movie_id
                INNER JOIN tb_language ON tb_language.lang_id = tb_movie_language.lang_id
                INNER JOIN tb_movie_dimension ON tb_movie.movie_id = tb_movie_dimension.movie_id
                INNER JOIN tb_dimension ON tb_dimension.dimension_id = tb_movie_dimension.dimension_id
                INNER JOIN tb_movie_cert ON tb_movie.movie_id = tb_movie_cert.movie_id
                INNER JOIN tb_certificate ON tb_movie_cert.cert_id = tb_certificate.cert_id
                WHERE tb_theater.id=<cfqueryparam value="#arguments.theaterId#" cfsqltype="CF_SQL_INTEGER">
                GROUP BY tb_theater.id,tb_movie.movie_id, tb_movie.name,tb_theater.name, dimension, cert_type,tb_theater.address,tb_theater.location	
        </cfquery>
        <cfreturn qryTheaterDetails>
    </cffunction>



    <cffunction  name="updateEventDetails" access="remote">
        <cfargument name="id" required="true">
        <cfargument name="eventName" required="true">
        <cfargument name="duration" required="true">       
        <cfargument name="rate" required="true">
        <cfargument name="date" required="true">

        <cfquery name="qryUpdateEventDetails">
            UPDATE tb_event
            SET
                name = <cfqueryparam value="#arguments.eventName#" cfsqltype="CF_SQL_VARCHAR">,
                date = <cfqueryparam value="#arguments.date#" cfsqltype="CF_SQL_DATE">,
                duration = <cfqueryparam value="#arguments.duration#" cfsqltype="CF_SQL_VARCHAR">,               
                rate = <cfqueryparam value="#arguments.rate#" cfsqltype="CF_SQL_INTEGER">
            WHERE event_id = <cfqueryparam value="#arguments.id#" cfsqltype="CF_SQL_INTEGER">
        </cfquery>

    </cffunction>


    <cffunction  name="deleteEvent" access="remote">
        <cfargument  name="eventId" >
        <cfquery name="qryDeleteEventVenue">
            DELETE FROM tb_event_venue WHERE event_id = <cfqueryparam value="#arguments.eventId#" cfsqltype="CF_SQL_INTEGER">
        </cfquery> 
        
    </cffunction>
   

    <cffunction  name="fecthLocations" access="remote" returntype="query">
        <cfquery name="qryFecthLocations">
            SELECT * FROM tb_venue
        </cfquery>
        <cfreturn qryFecthLocations>
    </cffunction>


    <cffunction  name="fecthVenues" access="remote" returntype="query">
        <cfargument  name="location">
        <cfquery name="qryFecthVenues">
            SELECT venue FROM tb_venue WHERE location=<cfqueryparam value="#arguments.location#" cfsqltype="CF_SQL_VARCHAR">
        </cfquery>        
            <cfreturn qryFecthVenues>
    </cffunction>


    <cffunction  name="fetchTheaterDetails" access="remote" returntype="query">
        <cfquery name="qryFetchTheaterDetails">
            SELECT * FROM tb_theater
        </cfquery>
        <cfreturn qryFetchTheaterDetails>
    </cffunction>


    <cffunction  name="saveEvent" access="public">
        <cfargument name="name">
       <cfargument name="date">
       <cfargument name="duration">
       <cfargument name="lang">
       <cfargument  name="category">
       <cfargument name="location">
       <cfargument name="venue">
       <cfargument name="rate">
       <cfargument name="fileupload1">
       <cfargument name="fileupload2">
       
       <cfset destination=ExpandPath("/bookmyShow/assests")>
       <cffile action = "upload" 
          fileField = "#arguments.fileupload1#"
          destination = "#destination#"
          nameConflict = "MakeUnique"
          allowedextensions=".jpg, .jpeg, .png" >
          <cfset profileFile = cffile.serverfile>
          
       <cffile action = "upload" 
       fileField = "#arguments.fileupload2#"
       destination = "#destination#"
       nameConflict = "MakeUnique"
       allowedextensions=".jpg, .jpeg, .png">
       <cfset coverFile = cffile.serverfile>

       <cfquery name="qryInsertEventDetails" result="insertResult">
            INSERT INTO tb_event(name,duration,rate,lang_id,cover_img,profile_img,date,category_id)
            VALUES(
               <cfqueryparam value="#arguments.name#" cfsqltype="CF_SQL_VARCHAR">,
               <cfqueryparam value="#arguments.duration#" cfsqltype="CF_SQL_VARCHAR">, 
               <cfqueryparam value="#arguments.rate#" cfsqltype="CF_SQL_INTEGER">, 
               <cfqueryparam value="#arguments.lang#" cfsqltype="CF_SQL_INTEGER">,
               <cfqueryparam value="#coverFile#" cfsqltype="CF_SQL_VARCHAR">,
               <cfqueryparam value="#profileFile#" cfsqltype="CF_SQL_VARCHAR">,
               <cfqueryparam value="#arguments.date#" cfsqltype="CF_SQL_DATE">,
               <cfqueryparam value="#arguments.category#" cfsqltype="CF_SQL_INTEGER">  

            )
       </cfquery>
       <!-- Get the ID of the newly inserted event -->
       <cfset local.newEventID =#insertResult.GENERATEDKEY#>
        <cfquery name="qryGetVenueId">
            SELECT venue_id
            FROM tb_venue
            WHERE 
            location =<cfqueryparam value="#arguments.location#" cfsqltype="CF_SQL_VARCHAR">
            AND
            venue =<cfqueryparam value="#arguments.venue#" cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfset local.venueId=#qryGetVenueId.venue_id#>

        <cfquery name="qryAddEventVenue">
            INSERT INTO tb_event_venue(event_id,venue_id)
            VALUES(
                    <cfqueryparam value="#local.newEventID#" cfsqltype="CF_SQL_INTEGER">, 
                    <cfqueryparam value="#local.venueId#" cfsqltype="CF_SQL_INTEGER">
            )            
        </cfquery>
       <cflocation  url="eventCrud.cfm">       
    </cffunction>
</cfcomponent>



