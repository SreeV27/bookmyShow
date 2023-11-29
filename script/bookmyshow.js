$(document).ready(function () {


   $("#invalid-otp").hide();
   $("#continue-btn").hide();
   $('#otpModal').hide();
   $("#resend-otp").hide();
   $("#continue-btn").prop('disabled', true);
   $('#continue-btn').css('background-color', '#A3636F');
   $("#otp-continue-btn").prop('disabled', true);
   $('#otp-continue-btn').css('background-color', '#A3636F');


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

   $('#mobileNo').on('input', function (e) {
      var mobileNo = ""
      // Remove non-digit characters using regular expression
      var inputValue = $(this).val().replace(/\D/g, '');
      $(this).val(inputValue);
      mobileNo += inputValue;

      if (mobileNo.length == 10) {
         $("#continue-btn").prop('disabled', false);
         $('#continue-btn').css('background-color', '#F84464');

      } else {
         $("#continue-btn").prop('disabled', true);
         $('#continue-btn').css('background-color', '#A3636F');
      }

   });

   $("#continue-btn").click(function () {

      $('.jLBVFy').val("");
      $("#mob-no").text($("#mobileNo").val());

      countdown();
      otp = generateOTP();

      // Toggle visibility of numberModal and otpModel
      $("#numModal").toggle();
      $("#otpModal").toggle();


   });


  

   $("#otp-modal-back-arrow").click(function () {
      appendedStringOTP = "";
      otp = "";
      clearInterval(timerId);
      $('.jLBVFy').val("");
      $("#numModal").toggle();
      $("#otpModal").toggle();
      $('.jLBVFy').css('border-color', '#CCCCCC')


   });

   $("#modal-close-btn").click(function () {
      appendedStringOTP = "";

      $("#mobileNo").val(" ");

   });


});

let otp = "";
function verifyOtp(){
   appendedStringOTP = $("#tel-1").val() + $("#tel-2").val() + $("#tel-3").val() + $("#tel-4").val() + $("#tel-5").val() + $("#tel-6").val();
   if (appendedStringOTP == otp) {
      $("#invalid-otp").hide();
   } else {
      $("#invalid-otp").show();
   }
   
}

// Function to generate OTP 
function generateOTP() {

   // Declare a digits variable  
   // which stores all digits 
   var digits = '0123456789';
   let otp = '';
   for (let i = 0; i < 6; i++) {
      otp += digits[Math.floor(Math.random() * 10)];
   }
   alert(otp);
   return otp;
}


function moveToPrevious(input) {
   // Check if Backspace key is pressed and the current input field is empty
   if (event.key === 'Backspace' && input.value === '') {
      var previousInput = input.previousElementSibling;

      while (previousInput) {
         if (previousInput.tagName === 'INPUT' && previousInput.type === 'tel') {
            previousInput.focus();
            input.style.borderColor = 'rgb(204, 204, 204)'; // Set border color of current input to gray
            // previousInput.style.borderColor = 'red'; // Set border color of previous input to red
            // previousInput.value = ''; // Clear the value of the previous input field
            break;
         }
         previousInput = previousInput.previousElementSibling;
      }
   }
}


var timerId;

function countdown() {
   var timeLeft = 30;
   var elem = document.getElementById('timer');

   timerId = setInterval(function () {
      if (timeLeft == -1) {
         clearInterval(timerId);
         $("#resend-otp").show();
         $("#except-otp").hide();

      } else {
         elem.innerHTML = timeLeft;
         timeLeft--;
      }
   }, 1000);
}


function handleInput(input) {

   //code for check the input is digit and move to next field

   var maxLength = parseInt(input.getAttribute('maxlength'));
   var currentLength = input.value.length;

   // Remove non-digit characters
   var inputValue = input.value.replace(/\D/g, '');

   // Update the input value with only digits
   input.value = inputValue;

   if (currentLength >= maxLength && /^\d+$/.test(inputValue)) {
      var nextInput = input.nextElementSibling;

      while (nextInput) {
         if (nextInput.tagName === 'INPUT' && nextInput.type === 'tel') {
            nextInput.focus();
            // input.style.borderColor = 'rgb(204, 204, 204)'; // Set border color of current input to gray
            // nextInput.style.borderColor = 'red'; // Set border color of next input to red
            break;
         }
         nextInput = nextInput.nextElementSibling;
      }
   }
}


let appendedStringOTP = "";
$(".jLBVFy").on('input', function (e) {

   appendedStringOTP = $("#tel-1").val() + $("#tel-2").val() + $("#tel-3").val() + $("#tel-4").val() + $("#tel-5").val() + $("#tel-6").val();


   if (appendedStringOTP.trim().length == 6) {
      $("#otp-continue-btn").prop('disabled', false);
      $('#otp-continue-btn').css('background-color', '#F84464');
   } else {
      $("#otp-continue-btn").prop('disabled', true);
      $('#otp-continue-btn').css('background-color', '#A3636F');
   }


});


$("#resend-otp").click(function () {


   appendedStringOTP = "";
   otp = "";
   clearInterval(timerId);
   $('.jLBVFy').val("");
   $("#resend-otp").hide();
   $("#except-otp").show();
   countdown();
   otp = generateOTP();

   // $("#otp-continue-btn").click(function () {


     

   // });


});