$(document).ready(function () {

    $("#continue-btn").hide();
    $('#otpModal').hide();
    $("#continue-btn").prop('disabled', true);
    $('#continue-btn').css('background-color', '#A3636F');
 
 
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

    $("#continue-btn").click(function(){

        generateOTP();
         // Toggle visibility of numberModal and otpModel
         $("#numModal").toggle();
         $("#otpModal").toggle();


    });
 
 
 });






  
// Function to generate OTP 
function generateOTP() { 
          
    // Declare a digits variable  
    // which stores all digits 
    var digits = '0123456789'; 
    let otp = ''; 
    for (let i = 0; i < 6; i++ ) { 
        otp += digits[Math.floor(Math.random() * 10)]; 
    } 
    // alert(otp);
}