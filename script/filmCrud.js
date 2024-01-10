
$(document).ready(function(){
    $("#statusDiv").hide();
    

});

$(".deleteMovieBtn").click(function () {
    var movieId = $(this).data("movieid");
    $.ajax({
       url: 'components/bookMyShow.cfc?method=deleteMovie',
       type: "POST",
       data: {
        movieId: movieId,
 
       },
       success: function (data) {
          alert("Deleted Successfully");
          location.reload();
 
       },
       error: function (jqXHR, textStatus, errorThrown) {
          console.error("AJAX Error: " + textStatus, errorThrown);
       }
 
 
    });
 
 });


 $(".view").click(function () {
    var movieId = $(this).data("movieid");
    $("#saveBtn").hide();
 
    $.ajax({
 
       url: 'components/bookMyShow.cfc?method=movieDetailsBasedOnId',
 
       // Type of Request
       type: "POST",
       data: {
        movieId: movieId
       },
       success: function (data) {
        console.log(data);
        $("#movieName").val($(data).find("field[name='NAME'] string").text());
        $("#duration").val($(data).find("field[name='DURATION'] string").text());
        $("#language").val($(data).find("field[name='LANGUAGE'] string").text());
        $("#genre").val($(data).find("field[name='GENRE'] string").text());
        $("#dimension").append('<option value="' + $(data).find("field[name='DIMENSION'] string").text() + '">' + $(data).find("field[name='DIMENSION'] string").text() + '</option>');
        $("#certificate").val($(data).find("field[name='CERT_TYPE'] string").text());
        $("#about").val($(data).find("field[name='ABOUT'] string").text());       
         
        let img = $(data).find("field[name='PROFILE_IMG'] string").text();
        let path = "assests/" + img;
        $("#profileImg").attr("src", path);

        $("#movieName").prop("disabled", true);
        $("#duration").prop("disabled", true);
        $("#language").prop("disabled", true);
        $("#genre").prop("disabled", true);
        $("#dimension").prop("disabled", true);
        $("#certificate").prop("disabled", true);
        $("#about").prop("disabled", true);

        
        
       },
       error: function (jqXHR, textStatus, errorThrown) {
          console.error("AJAX Error: " + textStatus, errorThrown);
       }
    });
 });


 $(".edit").click(function () {
    var movieId = $(this).data("movieid");
    $.ajax({
 
        url: 'components/bookMyShow.cfc?method=movieDetailsBasedOnId',
  
        // Type of Request
        type: "POST",
        data: {
         movieId: movieId
        },
        success: function (data) {
            var timeInput = document.getElementById("time");
            var convertedTime = convertTimeTo24HourFormat($(data).find("field[name='DURATION'] string").text());
          
            timeInput.value = convertedTime;
            $('#convertedTime').text(convertTo12HourFormat(convertedTime));          
            $("#editMovieName").val($(data).find("field[name='NAME'] string").text()); 
            $("#editLanguage").val($(data).find("field[name='LANGUAGE'] string").text());
            $("#editGenre").val($(data).find("field[name='GENRE'] string").text());         
            $("#editDimension").val($(data).find("field[name='DIMENSION'] string").text())
            $("#editCertificate").val($(data).find("field[name='CERT_TYPE'] string").text());
            $("#editAbout").val($(data).find("field[name='ABOUT'] string").text());       
            var statusValue = $(data).find("field[name='STATUS'] number").text();
            $("#editStatus").empty();
            if (statusValue == "1.0") {
                $("#editStatus").append('<option value="1" selected>Active</option>');
                $("#editStatus").append('<option value="0">Inactive</option>');
            } else {
                $("#editStatus").append('<option value="1">Active</option>');
                $("#editStatus").append('<option value="0" selected>Inactive</option>');
            }
            let img = $(data).find("field[name='PROFILE_IMG'] string").text();
            let path = "assests/" + img;
            $("#editProfileImg").attr("src", path);
    
            
    
            
         
        },
        error: function (jqXHR, textStatus, errorThrown) {
           console.error("AJAX Error: " + textStatus, errorThrown);
        }
     });
 
   
 
    $("#saveBtn").click(function () {
      
       $.ajax({
          url: 'components/bookMyShow.cfc?method=updateEventDetails',
          type: "POST",
          data: {
             
          },
          success: function (data) {
 
             alert("Updated");
             window.location.href = "eventCrud.cfm";
          },
          error: function (jqXHR, textStatus, errorThrown) {
             console.error("AJAX Error: " + textStatus, errorThrown);
          }
 
 
       });
 
    });
 });

 function convertTimeTo24HourFormat(timeString) {
    // Split the timeString into hours and minutes
    var timeArray = timeString.split(' ');

    // Extract hours and minutes from the array
    var hours = parseInt(timeArray[0].replace('h', ''), 10);
    var minutes = parseInt(timeArray[1].replace('m', ''), 10);

    // Convert to total minutes
    var totalMinutes = hours * 60 + minutes;

    // Convert to 24-hour format
    var hours24 = Math.floor(totalMinutes / 60);
    var minutes24 = totalMinutes % 60;

    // Format the result as "HH:mm"
    var formattedTime = ('0' + hours24).slice(-2) + ':' + ('0' + minutes24).slice(-2);

    return formattedTime;
}

$('#time').on('input', function () {
    var inputValue = $(this).val();
    var convertedTime = convertTo12HourFormat(inputValue);
    $('#convertedTime').text(convertedTime);
});

function convertTo12HourFormat(time24) {
    var timeArray = time24.split(':');
    var hours = parseInt(timeArray[0], 10);
    var minutes = timeArray[1];
   

    hours = hours % 12 || 12;

    // Format the time as "2h 30min"
    var formattedTime = hours + 'h ' + minutes + 'm ' ;
    
    return formattedTime;
}