<!DOCTYPE html>
<html lang="en">
   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>EventListing</title>
      <script src="script/jquery-3.6.4.js"></script>
      <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
      <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
      <script src="script/bootstrap-js.js"></script>    
  
      <link rel="stylesheet" href="style/bootstrap.css">
      <link rel="stylesheet" href="style/eventList.css">      
      <script src="script/eventListing.js"></script>
     
   </head>   
   <body class="bg-body-secondary">
    <cfinclude  template="header.cfm">
      <div class="ps-5">
         <img  src="assests/eventCover.jpg" alt="promotion-banner " width="95%">
      </div>
      <div class=" mainDiv">
         <div class=" w-25 filterMainDiv">
            <div class="filterTxt">Filters</div>
            
            <div class="dateDiv">
               <div class="headingDate">
                  <div class=" dateTxtDiv">
                     <svg id="svgDate" xmlns="http://www.w3.org/2000/svg" onclick="toggleCalendar()" viewBox="0 0 15 10">
                        <path fill="none" stroke="#666666" stroke-width="1.5" d="M335 3L342 9.5 335 16" transform="rotate(90 175.5 -158.5)"></path>
                     </svg>
                  </div>
                  <span id="dateTxt">Date</span>
                  <div class="clear"  onclick="clearCalendar()">Clear</div>
               </div>
               <input  type="text" class=" mt-2 ms-1 calender" name="calender" id="calender" >
            </div>


            <div class="dateDiv">
               <div class="headingDate">
                  <div class=" dateTxtDiv">
                     <svg id="svgLanguage" xmlns="http://www.w3.org/2000/svg" onclick="toggleLanguage()" viewBox="0 0 15 10">
                        <path fill="none" stroke="#666666" stroke-width="1.5" d="M335 3L342 9.5 335 16" transform="rotate(90 175.5 -158.5)"></path>
                     </svg>
                  </div>
                  <span id="languageTxt">Language</span>
                  <div class="clear"  onclick="">Clear</div>
               </div>

               <div class="langMainDiv" id="langMainDiv"> 
                  <div class=" langDiv">
                     <div class="  langTxt">English</div>
                  </div>
               </div>
               





            </div>
            

         </div>
      </div>
   </body>
</html>