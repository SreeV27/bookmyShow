
$(document).ready(function(){



});
var totalRate=0;
function changeStyle(element,rate,movieId,seatNo,theaterId) {
    
   
    var currentColor = window.getComputedStyle(element).backgroundColor;

    element.style.backgroundColor = (currentColor === 'rgb(30, 168, 60)') ? 'white' : 'rgb(30, 168, 60)';
    element.style.color = (currentColor === 'rgb(30, 168, 60)') ? '#1ea83c' : 'white';
    var time=$(".time").val();
    var date=$(".date").val();
    totalRate += rate;

   

    console.log(rate+":"+movieId+":"+seatNo+":"+theaterId+":"+time+":"+date+":"+totalRate);
    

  
}
