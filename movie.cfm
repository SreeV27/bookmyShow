<!DOCTYPE html>
<html lang="en">
   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Movie</title>
      <link rel="stylesheet" href="style/movie.css">
   </head>
   <body>
      <cfinclude  template="header.cfm">
      <cfparam name="URL.movieId" default="">

        <cfoutput>
            <p>Movie ID: #movieId#</p>
        </cfoutput>

        <cfinvoke  component="components/bookMyShow" method="fetchMovieDetailsBasedOnId" returnvariable="movie">
            <cfinvokeargument  name="movieId"  value="#movieId#">
        </cfinvoke >

        <cfdump var="#movie#">

        
            <cfloop query="movie">
                <cfoutput>
                    <div class="hhpXm" style="background-image: url(../assests/antony-cover.jpg)">    
                
                        <div class=" kSSnur">
                            <div class=" brstsF">
                                <section class=" hxpocV">
                                    <div type="vertical" class=" bGEZCd">
                                        <div class=" kUURKV" >
                                            <img src="assests/#movie.profile_img#" alt="#movie.name#" width="100%" height="100%" class="sc-echj48-5 hoyqAn" style="border-radius: 16px 16px 0px 0px; object-fit: cover;">
                                        </div>                           
                                    </div>
                                    <section type="vertical"  class="text-black fGbICE">
                                        <div class="sc-bsek5f-5 ePqEqS">
                                            <span class="text-white hnDFhW">In cinemas</span>
                                        </div>
                                    </section>
                                </section>
                            </div>
                            <div class=" ghYvew">
                                <h1 class="jevoyi">#movie.name#</h1>
                                <section class="dcnHkn">
                                    <div class=" jcAifu">                            
                                        <span class="kprskR">8.8/10</span>
                                        <span class="jACIue">5K Votes</span>                           
                                    </div>
                                </section>
                                <section class=" fyqJvB">
                                    <div class=" fLiHio">
                                        <div class="OqKaT">
                                            <h5 class=" eHiUDc">Add your rating &amp; review</h5>
                                            <h6 class=" gsfwZd">Your ratings matter</h6>
                                        </div>
                                        <button class="cJOuSt">
                                        <span>Rate now</span>
                                        </button>
                                    </div>
                                    <div class="keNWEl">
                                        <div class="OqKaT">
                                            <h5 class=" eHiUDc">Your rating</h5>
                                            <h6 class=" gsfwZd">Rated on 06 Dec 2023</h6>
                                        </div>
                                        
                                    </div>
                            </section>
                            <div class="ehJgFO">
                                <div class="kfhxuo">
                                    <div class="diGRHt">
                                        <a href="" class="fizEby text-decoration-none">#movie.dimension#</a>
                                    </div>
                                    <div class="diGRHt">
                                        <a href="" class=" fizEby text-decoration-none">#movie.language#</a>
                                    </div>
                                </div>
                                <div class="kfhxuo ">2h 27m
                                    <span class="juHVhn">  *  </span>
                                    <a href="" class="text-white bHMPWI text-decoration-none">#movie.genre#</a>
                                   
                                    
                                    <span class=" juHVhn">  *  </span>#movie.cert_type#
                                    <span class=" juHVhn text-black">  * #dateFormat(movie.release_date, 'dd mmm, yyyy')#</span>
                                </div>
                            </div>
                            <div class=" goilWl">
                                <div id="" class="bhdIdb">
                                    <button data-phase="postRelease" class="bGKFux">
                                        <div class="hhYlrx">
                                            <span style="font-weight: 500; font-size: 16px; color: rgb(255, 255, 255);">Book tickets</span>
                                        </div>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </cfoutput>
                
                


            </cfloop>            
      



   
   </body>
</html>