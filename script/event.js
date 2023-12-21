$(document).ready(function(){

    document.getElementById("eventBookingFormDiv").style.display = "none";
});
function openForm() {
    document.getElementById("eventBookingFormDiv").style.display = "block";
    document.getElementById("overlay").style.display = "block";
  }
  
  function closeForm() {
    document.getElementById("eventBookingFormDiv").style.display = "none";
    document.getElementById("overlay").style.display = "none";
  }

  function eventBookingConfirm(){
    alert("Booking Confirmed");
    

  }