$(".view").click(function(){

    var theaterId=$(this).data("theaterid");
    $.ajax({

        url: 'components/bookMyShow.cfc?method=fetchTheaterDetailsBasedOnId',
        // Type of Request
        type: "POST",
        data:{
            theaterId:theaterId
        },
        success: function (data) {            
            $("#theaterName").val($(data).find("field[name='NAME'] string").text());
            $("#address").val($(data).find("field[name='ADDRESS'] string").text());
            $("#location").append('<option value="' + $(data).find("field[name='LOCATION'] string").text() + '">' + $(data).find("field[name='LOCATION'] string").text() + '</option>');
            $("#phno").val($(data).find("field[name='PHNO'] string").text());
            $("#time").val($(data).find("field[name='TIMES'] string").text());

            $("#theaterName").prop("disabled", true);           
            $("#address").prop("disabled", true);           
            $("#location").prop("disabled", true);
            $("#phno").prop("disabled", true); 
            $("#time").prop("disabled", true);     
            $("#saveBtn").hide();    



        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.error("AJAX Error: " + textStatus, errorThrown);
         }


    });




});