$(document).ready(function () {


   $("#invalid-otp").hide();
   $("#continue-btn").hide();
   $('#otpModal').hide();
   $("#log-out").hide();
   $("#addTheater").hide();
   $("#addFilm").hide();
   $("#addEvent").hide();



   $("#login-continue-btn").prop('disabled', true);
   $('#login-continue-btn').css('background-color', '#A3636F');
   // $("#sign-continue-btn").prop('disabled', true);
   // $('#sign-continue-btn').css('background-color', '#A3636F');


   $("#mobileNo").focus(function () {
      // Show the button
      $("#continue-btn").show();
      $("#terms").hide();
   });


   $("#mobileNo").blur(function () {
      // Hide the button
      if ($(this).val().length == 0) {
         $("#continue-btn").hide();
         $("#terms").show();
      }
   });


   $('#phnneNo').on('input', function (e) {
      var phnneNo = ""
      // Remove non-digit characters using regular expression
      var inputValue = $(this).val().replace(/\D/g, '');
      $(this).val(inputValue);
      phnneNo += inputValue;


   });

   $('#mobileNo').on('input', function (e) {
      var mobileNo = ""
      // Remove non-digit characters using regular expression
      var inputValue = $(this).val().replace(/\D/g, '');
      $(this).val(inputValue);
      mobileNo += inputValue;

      if (mobileNo.length == 10) {
         $("#login-continue-btn").prop('disabled', false);
         $('#login-continue-btn').css('background-color', '#F84464');

      } else {
         $("#login-continue-btn").prop('disabled', true);
         $('#login-continue-btn').css('background-color', '#A3636F');
      }

   });


   $("#log-out").click(function () {


      // $('#sign-in').show();
      //    $('#log-in').show();    
      $.ajax({
         type: "POST",
         url: 'components/bookMyShow.cfc?method=logout',

         success: function (response) {

         },
         error: function (error) {
            console.error("Error changing session variable:", error);
         }
      });
      window.location.href = 'http://127.0.0.1:8500/bookmyShow/body.cfm';


   });


   $("#login-continue-btn").click(function () {

      var phone = $("#mobileNo").val();


      $.ajax({

         url: 'components/bookMyShow.cfc?method=fetchDetails',
         type: "POST",
         data: {
            phone: phone

         },

         success: function (data) {

            var parser = new DOMParser();
            var xmlDoc = parser.parseFromString(data, "text/xml");

            // Access the values using DOM methods
            var role = xmlDoc.querySelector("var[name='ROLE'] string").textContent;
            var name = xmlDoc.querySelector("var[name='NAME'] string").textContent;


            $("#mobileNo").val("");
            $('#sign-in').hide();
            $('#log-in').hide();
            $("#log-out").show();
            $('#loginInModal').modal('hide');
            $("#userName").text("Hi " + name);

            window.location.href = 'http://127.0.0.1:8500/bookmyShow/body.cfm';

         },
         error: function (jqXHR, textStatus, errorThrown) {
            console.error("AJAX Error: " + textStatus, errorThrown);
         }


      });


   });


   $(".closeBtn").click(function () {

      $("#mailError").text("");
      $("#nameError").text("");
      $("#mobileNo").val("");


   });


});


function validateEmail() {

   var mailError = $("#mailError");
   var mail = $("#mail").val().trim();
   var emailRegex = /[a-z0-9._]+@[a-z]+\.[a-z]{2,4}$/;
   if (emailRegex.test(mail)) {
      mailError.text("")

      return true;
   } else {
      mailError.text("Invalid email address")

      return false;

   }

}

function validateName() {
   var name = $('#name').val().trim();
   if (name.length > 0) {
      return true;
   } else {

      $("#nameError").text("Please Enter a Name");
      return false;
   }


}


function insertUser() {
   event.preventDefault()
   var name = $('#name').val().trim();
   var mail = $("#mail").val().trim();
   var phone = $("#phnneNo").val().trim();


   $.ajax({


      url: 'components/bookMyShow.cfc?method=insertUser',
      type: "POST",
      data: {
         name: name,
         mail: mail,
         phone: phone

      },

      success: function (data) {


         let result = $(data).find("boolean").attr("value");

         if (result === "true") {

            alert("User Already Exist");

         } else {
            alert("User Registered Successfully");
         }
         var name = $('#name').val("");
         var mail = $("#mail").val("");
         var phone = $("#phnneNo").val("");
         $('#signInModal').modal('hide');
      },


      error: function (jqXHR, textStatus, errorThrown) {
         console.error("AJAX Error: " + textStatus, errorThrown);
      }


   });


}

function validateForm() {

   var isValidateEmail = validateEmail();
   var isValidateName = validateName();
   if (isValidateEmail && isValidateName) {
      insertUser();
   } else {

      event.preventDefault();
      return false;
   }


}