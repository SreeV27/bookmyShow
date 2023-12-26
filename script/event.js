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

    

    var selectElement = document.getElementById("seatSelect");
        // Get the selected value
    var seats = selectElement.value;
    var userId=$("#userId").val();
    var eventId=$("#eventId").val();


    $.ajax({

      type: "POST",
      url: 'components/bookMyShow.cfc?method=saveEventBookingDetails',
      data: {
        seats:seats,
        eventId:eventId,
        userId:userId
         
      },
      success:function(response){
        console.log(response);
        alert("Booking Confirmed");
    

      },
      error: function (error) {
        console.error("Error changing session variable:", error);
     }


    });
    

  }