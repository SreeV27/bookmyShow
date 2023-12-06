<!DOCTYPE html>
<html lang="en">
   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Book my show</title>
   </head>
   <body>
      <cfinclude  template="header.cfm">
      <div class=" VWWsY px-5 pt-5">
         <div class="jZYART">
            <h2 class=" hpMgIh">Recommended Movies</h2>
         </div>
         <div class=" lmvNfK">
            <a href="" class="kVTwJy">
               <div class="gfZBKV">See All ></div>
            </a>
         </div>
      </div>
      <div class=" jhuTSq mt-2 px-5">
         <div class=" kNWDcM">
            <div class=" YeNog">
               <cfinvoke  component="components/bookMyShow" method="fetchMovieDetails" returnvariable="movies">
               </cfinvoke>
               <cfloop query="movies">
                  <cfoutput>
                     <div>
                        <a href="movie.cfm?movieId=#movies.movieId#" id="" class=" kcFNYT">
                           <div class="crxcDb">
                              <div class="byaznB">
                              </div>
                              <div width="100%" height="100%"  class="ktUzoz">
                                 <div class=" dXHMBz">
                                    <img src="assests/#movies.profile_img#" alt="#movies.name#" width="100%" height="100%">
                                    <div class="rating text-white fs-15 d-flex justify-content-around">                                          
                                       <span class="d-flex"><img class="me-2" src="assests/star.png" alt="star" width="20" height="20">#movies.rating#/10</span>
                                       <span>6.7k Votes</span>
                                    </div>
                                 </div>
                              </div>
                              <div class="dVLjTu">
                                 <div class=" cIKQwG">
                                    <div class=" eJQlCo">#movies.name#</div>
                                 </div>
                                 <div class="cIKQwG">
                                    <div class=" fIlqSN">#movies.genre# </div>
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

      <div class=" VWWsY px-5 pt-5">
         <div class="jZYART">
            <h2 class=" hpMgIh">Events</h2>
         </div>
         <div class=" lmvNfK">
            <a href="" class="kVTwJy">
               <div class="gfZBKV">See All ></div>
            </a>
         </div>
      </div>

      <div class=" jhuTSq mt-2 px-5">
         <div class=" kNWDcM">
            <div class=" YeNog">
               <cfinvoke  component="components/bookMyShow" method="fetchEventDetails" returnvariable="event">
               </cfinvoke>
               <cfloop query="event">
                  <cfoutput>
                     <div>
                        <a href= class=" kcFNYT">
                           <div class="crxcDb">
                              <div class="byaznB">
                              </div>
                              <div width="100%" height="100%"  class="ktUzoz">
                                 <div class=" dXHMBz">
                                    <img src="assests/#event.profile_img#" alt="#event.name#" width="100%" height="100%">
                                    <div class="rating text-white fs-15 ">                                          
                                       <span class="d-flex ms-2">
                                          #dateFormat(event.date, 'ddd, dd mmm')#
                                      </span>                                    
                                       
                                    </div>
                                 </div>
                              </div>
                              <div class="dVLjTu">
                                 <div class=" cIKQwG">
                                    <div class=" eJQlCo">#event.name#</div>
                                 </div>
                                 <div class="cIKQwG">
                                    <div class=" fIlqSN">#event.venue#:#event.location# </div>
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