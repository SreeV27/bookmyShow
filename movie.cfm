<!DOCTYPE html>
<html lang="en">
   <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie</title>    
    <script src="script/jquery-3.6.4.js"></script>
    <link rel="stylesheet" href="style/movie.css">
    <script src="script/movie.js"></script>  
   </head>
   <body>
        <cfif session.userId gt 0>

            <cfinclude  template="header.cfm">
            
            <cfparam name="URL.movieId" default="">
            <cfinvoke  component="components/bookMyShow" method="fetchMovieDetailsBasedOnId" returnvariable="movie">
                <cfinvokeargument  name="movieId"  value="#movieId#">
            </cfinvoke >
            <cfloop query="movie">
                <cfoutput>
                    <div class="movie">
                        <div class="hhpXm" id="movieDiv"> 
                            <input type="hidden" id="profile_img" value="assests/#movie.cover_img#">   
                    
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
                                            <span class="kprskR d-flex"><img class="me-2" src="assests/star.png" alt="star" width="25" height="25">#movie.rating#/10</span>
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
                                    <div class="kfhxuo ">#movie.duration#
                                        <span class="juHVhn">  *  </span>
                                        <a href="" class="text-white bHMPWI text-decoration-none">#movie.genre#</a>
                                        
                                        
                                        <span class=" juHVhn">  *  </span>#movie.cert_type#
                                        <span class=" juHVhn ">  * #dateFormat(movie.release_date, 'dd mmm, yyyy')#</span>
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
                    </div>
                    <section class=" jCydZa bg-white">
                        <span class=" fegzLx">
                            <h4 class="fdvlVN">About the movie</h4>
                            <div class="eAlXok">
                                <span class="fs-16">#movie.about#</span>
                            </div>
                        </span>
                    </section>
                </cfoutput>
            </cfloop> 
            <cfinclude  template="footer.cfm">
            <cfelse>
                <cflocation  url="body.cfm">
        </cfif>          
   </body>
</html>