<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>MovieList</title>
        <link rel="stylesheet" href="style/movieList.css">
        <link rel="stylesheet" href="style/bootstrap.css">
    </head>
    <body>

        <cfobject component="components/bookMyShow" name="myComponent">
        <cfinclude  template="header.cfm">
        <cfinclude  template="slide.cfm">
        <h1 class="ms-5 ps-5 w-75 heading-txt">Movies</h1>
        <cfset local.movie=myComponent.fetchAllMovieDetails()>
        <cfoutput>

            <div class="">
                    <div class="movieRowDiv">
                        <cfloop query="local.movie">
                            <cfscript>
                                myMessage = "#local.movie.movieId#"  
                                encryptedMsg = encrypt(myMessage,#application.key#,"DES", 'Base64'); 
                             </cfscript> 
                                                       
                        <a href="movie.cfm?encryptedMsg=#encryptedMsg#" class="movieDiv">
                                <div class=" movieDetailsDiv">                
                                    <div width="100%" height="100%" data-content="Animal" class="profilePicDiv">
                                        <div class=" imgLink">
                                            <img src="assests/#local.movie.profile_img#"  alt="Animal" width="100%" height="100%">
                                        </div>
                                    </div>
                                    <div class="movieNameDiv" style="">
                                            <div >
                                                <div class="movie-heading-txt">#local.movie.name#</div>
                                            </div>
                                            <div >
                                                <div class="genre-txt">#local.movie.cert_type#</div>
                                            </div>
                                        <div class="">
                                            <div class="genre-txt"> #local.movie.language#</div>
                                        </div>                
                                    </div>
                            </div>
                        </a>            
                    </cfloop> 

            </div>
        </cfoutput>



        <cfinclude  template="footer.cfm">
    </body>
</html>