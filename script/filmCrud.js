$(document).ready(function () {
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
         console.log(data);
         var timeInput = document.getElementById("time");
         var convertedTime = convertTimeTo24HourFormat($(data).find("field[name='DURATION'] string").text());
         timeInput.value = convertedTime;
         $('#convertedTime').text(convertTo12HourFormat(convertedTime));
         $("#editMovieName").val($(data).find("field[name='NAME'] string").text());
         $("#editLanguage").val($(data).find("field[name='LANGUAGE'] string").text());

         var languageValues = $(data).find("field[name='LANGUAGE'] string").text().split('/');
         // Loop through the language values
         languageValues.forEach(function (value) {
            // Remove the corresponding option from the select element
            $(".langInput option:contains('" + value + "')").remove();
         });

         $("#editGenre").val($(data).find("field[name='GENRE'] string").text());
         var genreValues = $(data).find("field[name='GENRE'] string").text().split('/');
         // Loop through the genre values
         genreValues.forEach(function (value) {
            // Remove the corresponding option from the select element
            $(".genreInput option:contains('" + value + "')").remove();
         });


         $("#editDimension").val(parseInt($(data).find("field[name='DIMENSIONID'] number").text()));
         $("#editCertificate").val(parseInt($(data).find("field[name='CERTID'] number").text()));
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
     
      var duration=$("#convertedTime").text();
      var langId=getAllSelectedLang();
      var genreId=getAllSelectedGenre();
      var name =$("#editMovieName").val();
      var dimension =$("#editDimension").val();
      var status =$("#editStatus").val();
      var cert =$("#editCertificate").val();
      var about =$("#editAbout").val();
      $.ajax({

         url: 'components/bookMyShow.cfc?method=updateMovieDetails',
   
         // Type of Request
         type: "POST",
         data: {
            name:name,
            movieId: movieId,
            duration:duration,
            langId:langId,
            genreId:genreId,
            dimension:dimension,
            status:status,
            cert:cert,
            about:about
         },
         success: function (data) {
           alert("Updated Successfully");
           window.location.href = "filmCrud.cfm";
          
   
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
   var formattedTime = hours + 'h ' + minutes + 'm ';

   return formattedTime;
}

function toggleLangDiv() {
   var selectDiv = document.getElementById("selectLangDiv");
   var selectbtn = document.getElementById("add");

   // Get the computed style of the element
   var computedStyle = window.getComputedStyle(selectDiv);

   // Toggle the visibility of the div
   if (computedStyle.display === "none") {
      selectDiv.style.display = "block";
      selectbtn.style.display = "none";
   } else {
      selectDiv.style.display = "none";
      selectbtn.style.display = "block";
   }
}

function addLanguage() {
   // Clone the existing time container
   var originalLangContainer = document.querySelector('.lang-container');
   var clonedLangContainer = originalLangContainer.cloneNode(true);

   // Clear the value of the cloned time input
   var clonedLangInput = clonedLangContainer.querySelector('.langInput');
   clonedLangInput.value = '';
   clonedLangInput.selectedIndex = 0;

   // Append the cloned container to the timeContainer div
   document.getElementById('langContainer').appendChild(clonedLangContainer);
   event.preventDefault();
}

function getAllSelectedLang() {
   // Get all the selected <option> elements in all select elements
   var selectedOptions = Array.from(document.querySelectorAll('.langInput option:checked'));

   // Get an array of values from the selected <option> elements
   var selectedValues = selectedOptions.map(function (option) {
      return option.value;
   });
   return (selectedValues.join(','));


}

function toggleGenreDiv() {
   var selectDiv = document.getElementById("selectGenreDiv");
   var selectbtn = document.getElementById("addGenre");

   // Get the computed style of the element
   var computedStyle = window.getComputedStyle(selectDiv);

   // Toggle the visibility of the div
   if (computedStyle.display === "none") {
      selectDiv.style.display = "block";
      selectbtn.style.display = "none";
   } else {
      selectDiv.style.display = "none";
      selectbtn.style.display = "block";
   }
}

function addGenre() {
   // Clone the existing time container
   var originalGenreContainer = document.querySelector('.genre-container');
   var clonedGenreContainer = originalGenreContainer.cloneNode(true);

   // Clear the value of the cloned time input
   var clonedGenreInput = clonedGenreContainer.querySelector('.genreInput');
   clonedGenreInput.value = '';
   clonedGenreInput.selectedIndex = 0;

   // Append the cloned container to the timeContainer div
   document.getElementById('genreContainer').appendChild(clonedGenreContainer);
   event.preventDefault();
}

function getAllSelectedGenre() {
   // Get all the selected <option> elements in all select elements
   var selectedOptions = Array.from(document.querySelectorAll('.genreInput option:checked'));

   // Get an array of values from the selected <option> elements
   var selectedValues = selectedOptions.map(function (option) {
      return option.value;
   });
   return (selectedValues.join(','));


}