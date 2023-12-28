<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
    <title>seat</title>
    <script src="script/jquery-3.6.4.js"></script>
    <link rel="stylesheet" href="style/googleFont.css">
    <link rel="stylesheet" href="style/bootstrap.css">
    <link rel="stylesheet" href="style/theaterList.css">
    <link rel="stylesheet" href="style/seat.css">
    <script src="script/seat.js" ></script>
</head>
    <body>
        <cfobject component="components/bookMyShow" name="objBookMyShow">
        <cfif structKeyExists(form,"movieId")>
            <cfset local.movieId="#form.movieId#">
            <cfset local.theaterId="#form.theaterId#">
            <cfset local.time="#form.time#">
            <cfset local.date="#form.date#">
        </cfif>
        <cfset local.theater=objBookMyShow.theaterDetailsBasedOnId(local.theaterId)>
        <cfset local.movieList=objBookMyShow.fetchMovieDetailsBasedOnId(local.movieId) >
        <cfoutput>
            <div class="d-flex header justify-content-between pe-3">   
                <div class="d-flex">
                    <form action="theaterList.cfm" class="text-black">
                        <input type="hidden" name="movieId" value="#local.movieId#">
                        <button type="submit" class="border-0 bg-white">
                            <span class="material-symbols-outlined mt-1">
                                arrow_back_ios
                            </span>
                        </button>                        
                    </form>
                    
                    <div>
                        <div class="d-flex">
                            <div>#local.movieList.name#</div>
                            <span class=" ms-1 ">
                                <span class="movie-cert p-1 fs-9">#local.movieList.cert_type#</span>
                            </span>  
                        </div>
        
                        <div class="theater-date-details">
                            #local.theater.name#: #local.theater.location# | #dateFormat(local.date, 'ddd, dd mmm')#, #local.time#
                        </div>
                    </div> 
                </div>     
                <div>
                    <form action="theaterList.cfm" class="text-black">
                        <input type="hidden" name="movieId" value="#local.movieId#">
                        <button type="submit" class="border-0 bg-white"><span class="material-symbols-outlined ">
                            close
                        </span></button>                        
                    </form>
                </div>                        
            </div>
            <div class="ps-5 d-flex bg-light py-2">
                <cfset timeArray = listToArray(local.theater.times, ",")>                                    
                <cfloop array="#timeArray#" index="time">                                           
                        <button  type="submit" class="bg-white theater-time ms-3" >#time#</button>                    
                                                      
                </cfloop>    
            </div>
            <cfset local.seatList=objBookMyShow.getSeatDetails()>

            <form id="#local.seatList.type#">  
                <div class="seatDiv pt-3">
                    <cfloop query="local.seatList">
                        <div class="seatType mt-2">#local.seatList.type#-Rs. #local.seatList.rate#.00</div>                      
                            <input type="hidden" name="movieId" id="movieId" value="#local.movieId#">                                            
                            <input type="text" name="time" class="time" value="#local.time#">
                            <input type="text" name="date" id="date" class="date" value="#local.date#">
                            <input type="hidden" name="theaterId" id="theaterId" value="#local.theaterId#"> 
                            <input type="hidden" name="rate" id="rate" class="rate" value="#local.seatList.rate#">                   
                            <cfif local.seatList.seats EQ 10>
                                <table class="m-auto">
                            <cfelse>
                                <table>
                            </cfif>  
                                    <tr>
                                        <cfloop from="1" to="#local.seatList.seats#" index="i">
                                            <td >
                                                <div class="seat mx-2 mt-2" onclick="changeStyle(this,#local.seatList.rate#,#local.movieId#,#i#,#local.theaterId#)" data-form="#local.seatList.type#" id="#i#">#i#</div>
                                            </td>
                                            <cfif i % 20 EQ 0>
                                                </tr>
                                                <tr >
                                            </cfif>
                                        </cfloop>
                                    </tr>
                                </table>                                                             
                    </cfloop>                
                    <div class="eye-text text-center mt-5 pt-5">All eyes this way please!</div>
                    <div class="text-center mt-5">                    
                        <button class="payBtn fs-15" type="submit" >Pay </button>
                    </div>
                </div>
            </form> 
        </cfoutput>
    </body>
</html>