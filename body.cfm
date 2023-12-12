<!DOCTYPE html>
<html lang="en">
   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Book my show</title>
      <script src="script/jquery-3.6.4.js"></script>
   </head>
   <body>
      <cfobject component="components/bookMyShow" name="myComponent">
      <cfinclude  template="header.cfm">
      <cfinclude  template="slide.cfm">
      <div class=" titleDiv px-5 ">
         <div class="textDiv">
            <h2 class=" text-1">Recommended Movies</h2>
         </div>
         <div class=" ">
            <a href="movieList.cfm" class="text2style">
               <div class="text-2">See All ></div>
            </a>
         </div>
      </div>
      <div class=" movieMainDiv mt-2 px-5">
         <div class=" movieListDiv">
            <div class=" moviesDiv">               
               <cfset local.movies=myComponent.fetchAllMovieDetails()>
               <cfloop query="local.movies">
                  <cfoutput>
                     <div>                        
                        <cfscript>
                           myMessage = "#local.movies.movieId#"  
                           encryptedMsg = encrypt(myMessage,#application.key#,"DES", 'Base64');
                           
                           //writeOutput(encryptedMsg); 
                           // Assuming encryptedMsg is the encrypted message obtained from the encryption process
                          // decryptedMsg = decrypt(encryptedMsg, #application.key#, 'AES', 'Base64');                           
                           // Output the decrypted message
                          // writeOutput(decryptedMsg);
                        </cfscript>                                       
                        <a href="movie.cfm?encryptedMsg=#encryptedMsg#" id="" class=" movieLink">
                           <div >
                              <div class="">
                              </div>
                              <div width="100%" height="100%" >
                                 <div class=" movieImg">
                                    <img src="assests/#local.movies.profile_img#" alt="#local.movies.name#" width="100%" height="100%">
                                    <div class="rating text-white fs-15 d-flex justify-content-around">                                          
                                       <span class="d-flex"><img class="me-2" src="assests/star.png" alt="star" width="20" height="20">#local.movies.rating#/10</span>
                                       <span>6.7k Votes</span>
                                    </div>
                                 </div>
                              </div>
                              <div class="detailsDiv">
                                 <div class=" ">
                                    <div class="movieName">#local.movies.name#</div>
                                 </div>
                                 <div class="">
                                    <div class="movieGenre">#local.movies.genre# </div>
                                 </div>
                              </div>
                           </div>
                        </a>   
                     </div>
                  </cfoutput>
               </cfloop>
            </div>
         </div>
      </div>
      <div class="streamDiv px-5 mt-3">
         <img src="https://assets-in.bmscdn.com/discovery-catalog/collections/tr:w-1440,h-120/stream-leadin-web-collection-202210241242.png" alt="Stream" width="100%" height="100%">
      </div>
      <div class=" titleDiv px-5 pt-5">
         <div class="textDiv">
            <h2 class=" text-1">Events</h2>
         </div>
         <div class=" ">
            <a href="eventList.cfm" class="text2style">
               <div class="text-2">See All ></div>
            </a>
         </div>
      </div>
      <div class=" movieMainDiv mt-2 px-5">
         <div class=" movieListDiv">
            <div class="moviesDiv">
               <cfinvoke  component="components/bookMyShow" method="fetchEventDetails" returnvariable="event">
               </cfinvoke>
               <cfloop query="event">
                  <cfoutput>
                     <div>
                        <a href= class=" movieLink">
                           <div >
                              <div class="">
                              </div>
                              <div width="100%" height="100%" >
                                 <div class=" movieImg">
                                    <img src="assests/#event.profile_img#" alt="#event.name#" width="100%" height="100%">
                                    <div class="rating text-white fs-15 ">                                          
                                       <span class="d-flex ms-2">
                                          #dateFormat(event.date, 'ddd, dd mmm')#
                                      </span>                                    
                                       
                                    </div>
                                 </div>
                              </div>
                              <div class="detailsDiv">
                                 <div class=" ">
                                    <div class=" movieName">#event.name#</div>
                                 </div>
                                 <div class="">
                                    <div class=" movieGenre">#event.venue#:#event.location# </div>
                                 </div>
                              </div>
                           </div>
                        </a>
                     </div>
                  </cfoutput>
               </cfloop>
            </div>
         </div>
      </div>
      <cfinclude  template="footer.cfm">
   </body>
</html>