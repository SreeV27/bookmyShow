
<cfobject component="components/bookMyShow" name="objBookMyShow">
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
<div class="movieMainDiv mt-2 px-5">
   <div class="movieListDiv">
      <div class="moviesDiv">
         <cfset local.movies=objBookMyShow.fetchAllMovieDetails()>
         <cfloop query="local.movies">
            <cfoutput>
               <div> 
                  <cfscript>
                     //myMessage = "#local.movies.movieId#"  
                     // Encrypt with AES/CBC/PKCS5Padding and Base64 encoding
                     //encryptedMsg = encrypt(myMessage, application.key, 'AES', 'Base64');                           
                     //writeOutput(encryptedMsg); 
                     // Assuming encryptedMsg is the encrypted message obtained from the encryption process
                     // decryptedMsg = decrypt(encryptedMsg, #application.key#, 'AES', 'Base64');                           
                     // Output the decrypted message
                     // writeOutput(decryptedMsg);
                  </cfscript>
                  <a href="movie.cfm?encryptedId=#local.movies.movieId#" id="" class=" movieLink">
                     <div >
                        <div class="">
                        </div>
                        <div width="100%" height="100%" >
                           <div class="movieImg">
                              <img src="assests/#local.movies.profile_img#" alt="#local.movies.name#" width="100%" height="100%">
                              <div class="rating text-white fs-15 d-flex justify-content-around">                                          
                                 <span class="d-flex"><img class="me-2" src="assests/star.png" alt="star" width="20" height="20">#local.movies.rating#/10</span>
                                 <span>6.7k Votes</span>
                              </div>
                           </div>
                        </div>
                        <div class="detailsDiv">
                           <div>
                              <div class="movieName">#local.movies.name#</div>
                           </div>
                           <div>
                              <div class="movieGenre">#local.movies.genre#</div>
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
         <cfset local.event=objBookMyShow.fetchEventDetails()>
         <cfloop query="local.event">
            <cfoutput>
               <div>
                  <a href="event.cfm?eventId=#local.event.event_id#" class=" movieLink">
                     <div >
                        <div >
                        </div>
                        <div width="100%" height="100%" >
                           <div class=" movieImg">
                              <img src="assests/#local.event.profile_img#" alt="#local.event.name#" width="100%" height="100%">
                              <div class="rating text-white fs-15 ">                                          
                                 <span class="d-flex ms-2">
                                 #dateFormat(local.event.date, 'ddd, dd mmm')#
                                 </span>                                    
                              </div>
                           </div>
                        </div>
                        <div class="detailsDiv">
                           <div >
                              <div class=" movieName">#local.event.name#</div>
                           </div>
                           <div>
                              <div class=" movieGenre">#local.event.venue#:#local.event.location# </div>
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
