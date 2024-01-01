<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
</head>
    <body>
        <cfobject component="components/bookMyShow" name="objBookMyShow">
        <cfif structKeyExists(form,"searchValue") && trim(form.searchValue) NEQ "">
            <cfset local.result =objBookMyShow.searchValue(#form.searchValue#)>
            <cfif local.result.flag == 1>           
                <cfset local.encryptedMovieId= encrypt(local.result.id,#application.key#,'AES', 'Base64')>
                <cfset local.encryptedMovieId = replace(local.encryptedMovieId, "+", "!", "all")>
                <cfset local.encryptedMovieId = replace(local.encryptedMovieId, "\", "@", "all")>
                <cflocation url="movie.cfm?movieId=#local.encryptedMovieId#" >

            <cfelseif local.result.flag == 2>
                <cfset local.encryptedEventId= encrypt(local.result.id,#application.key#,'AES', 'Base64')>
                <cfset local.encryptedEventId = replace(local.encryptedEventId, "+", "!", "all")>
                <cfset local.encryptedEventId = replace(local.encryptedEventId, "\", "@", "all")>
                <cflocation url="event.cfm?eventId=#local.encryptedEventId#" >

            <cfelseif local.result.flag == 3>
           </cfif>                
            



        <cfelse>
            <cflocation url="body.cfm">

        
        </cfif>
    
    
    </body>
</html>