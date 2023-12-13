
$(document).ready(function(){

    $("#calender").hide();
    $("#langMainDiv").hide();
    


});

$(function () {
    $("#calender").datepicker();
   
});

function clearCalendar() {
    // Get the calender input element
    var calenderInput = document.getElementById("calender");

    // Clear the value of the calender input field
    calenderInput.value = "";
}

function toggleCalendar() {
    var calendar = document.getElementById('calender');
    var svgDate = document.getElementById('svgDate');
    var dateTxt=document.getElementById('dateTxt')
    var dateField=document.getElementById("calender")

    if (calendar.style.display === 'none') {
        calendar.style.display = 'block';
        svgDate.classList.add('rotate-down');
        dateTxt.style.color='red';
      
    } else {
        calendar.style.display = 'none';
        svgDate.classList.remove('rotate-down');
        dateTxt.style.color='black';
        dateField.value="";
        
    }
}


document.addEventListener('DOMContentLoaded', function () {
  var langMainDiv = document.querySelector('.langMainDiv');
  var langDiv = document.querySelector('.langDiv');

  langMainDiv.addEventListener('click', function () {
    langDiv.classList.toggle('active');
  });
});


function toggleLanguage() {
    var lang = document.getElementById('langMainDiv');
    var svgLanguage = document.getElementById('svgLanguage');
    var languageTxt=document.getElementById('languageTxt')
   

    if (lang.style.display === 'none') {
        lang.style.display = 'block';
        svgLanguage.classList.add('rotate-down');
        languageTxt.style.color='red';
      
    } else {
        lang.style.display = 'none';
        svgLanguage.classList.remove('rotate-down');
        languageTxt.style.color='black';
        
        
    }
}