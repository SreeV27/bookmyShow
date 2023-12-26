<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>theater</title>
    <script src="script/jquery-3.6.4.js"></script>
    <link rel="stylesheet" href="style/jquery-ui.css">
    <script src="script/jquery-ui.js"></script>
    <script src="script/bootstrap-js.js"></script>
    <script src="script/theater.js"></script>
    <link rel="stylesheet" href="style/theaterList.css">
    
</head>
    <body>
        <cfobject component="components/bookMyShow" name="objBookMyShow">
        <cfinclude  template="header.cfm">
        <cfoutput>
            <div class="pb-3 movie-details-div">
                <div class="movie-name pt-3 ps-3" >Neru - Malayalam</div>
                <div class="d-flex">
                    <div class="movie-cert ms-4">
                        <span class="fs-11">UA</span>
                    </div>
                    <div class="movie-genre fs-11 px-2 pt-1 ms-2">Drama</div>
                </div> 
            </div>
            <input  type="hidden" class="ms-3 mt-2 ms-1 calender text-white" name="calender"  id="calender"  onchange="formatDate()"/>
        </cfoutput> 

    <div class="dateDiv ms-3 py-2" id="datepickerTrigger"> 
        <div id="weekday" class="date">Pick</div>
        <div id="day" class="date">a</div>
        <div id="month" class="date">Date</div>
    </div>
    </body>
</html>