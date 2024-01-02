$(".view").click(function(){
    var eventId = $(this).data("eventid");

    $.ajax({
 
        url: 'components/bookMyShow.cfc?method=eventDetailsBasedOnId',

        // Type of Request
        type: "POST",
        data: {
            eventId: eventId
        },
        success: function (data) {
            console.log(data);
            var eventName = $("#eventName").val($(data).find("field[name='NAME'] string").text());
            var date = $("#date").val($(data).find("field[name='DATE'] dateTime").text());
            var duration = $("#duration").val($(data).find("field[name='DURATION'] string").text());
            var location = $("#location").val($(data).find("field[name='LOCATION'] string").text());
            var venue = $("#venue").val($(data).find("field[name='VENUE'] string").text());
            var rate = $("#rate").val($(data).find("field[name='RATE'] number").text());
            $("#eventName").prop("disabled", true);
            $("#date").prop("disabled", true);
            $("#duration").prop("disabled", true);
            $("#location").prop("disabled", true);           
            $("#venue").prop("disabled", true);
            $("#rate").prop("disabled", true);
            $("#saveBtn").hide()

        },
        error: function (jqXHR, textStatus, errorThrown) {
           console.error("AJAX Error: " + textStatus, errorThrown);
        }
     });
});


$(".edit").click(function(){
    var eventId = $(this).data("eventid");

    $.ajax({
 
        url: 'components/bookMyShow.cfc?method=eventDetailsBasedOnId',

        // Type of Request
        type: "POST",
        data: {
            eventId: eventId
        },
        success: function (data) {
            console.log(data);
            var eventName = $("#eventName").val($(data).find("field[name='NAME'] string").text());
            var date = $("#date").val($(data).find("field[name='DATE'] dateTime").text());
            var duration = $("#duration").val($(data).find("field[name='DURATION'] string").text());
            var location = $("#location").val($(data).find("field[name='LOCATION'] string").text());
            var venue = $("#venue").val($(data).find("field[name='VENUE'] string").text());
            var rate = $("#rate").val($(data).find("field[name='RATE'] number").text());  
            $("#eventName").prop("disabled", false);
            $("#date").prop("disabled", false);
            $("#duration").prop("disabled", false);
            $("#location").prop("disabled", false);           
            $("#venue").prop("disabled", false);
            $("#rate").prop("disabled", false);
            $("#saveBtn").show()        

        },
        error: function (jqXHR, textStatus, errorThrown) {
           console.error("AJAX Error: " + textStatus, errorThrown);
        }
     });

     $("#saveBtn").click(function () {

        var eventName = $("#eventName").val();
        var date = $("#date").val();
        var duration = $("#duration").val();
        var location = $("#location").val();
        var venue =$("#venue").val();
        var rate =$("#rate").val();

        
        $.ajax({

            url: 'components/bookMyShow.cfc?=updateEventDetails',
            type: "POST",
            data: {
               id: pageId,
               pageName: pageName,
               pageDescription: pageDescription
 
            },
            success: function (data) {          
               location.reload(true);
            },
            error: function (jqXHR, textStatus, errorThrown) {
               console.error("AJAX Error: " + textStatus, errorThrown);
            }
 
 
         });



     });
});



$("#closeBtn").click(function(){

    location.reload();
});