
$(document).ready(function(){

    $("#calender").hide();  
    $("#lang").hide();
    $("#categories").hide();
    $("#calender").datepicker({
        onSelect: function(dateText, inst) {
          // When a date is picked, set the value to the second input field
          $("#filterDate").val(dateText);
        },
        onClose: function() {
          // When the datepicker is closed, check if the calendar field is empty, and clear the second input field if it is
          var calendarValue = $("#calender").val();
          if (!calendarValue) {
            $("#filterDate").val("");
          }
        }
      });
      

});


$(function () {
    $("#calender").datepicker();
   
});


function toggleCalendar() {
    var calendar = document.getElementById('calender');
    var svgDate = document.getElementById('svgDate');
    var dateTxt=document.getElementById('dateTxt')
    

    if (calendar.style.display === 'none') {
        calendar.style.display = 'block';
        svgDate.classList.add('rotate-down');
        dateTxt.style.color='red';
      
    } else {
        calendar.style.display = 'none';
        svgDate.classList.remove('rotate-down');
        dateTxt.style.color='black';
       
        
    }
}

function toggleLanguage() {
   
    var svgLanguage = document.getElementById('svgLanguage');
    var languageTxt=document.getElementById('languageTxt')
    var main = document.getElementById('lang');
   

    if (main.style.display==='none') {
        
        main.style.display = 'block';
        svgLanguage.classList.add('rotate-down');
        languageTxt.style.color='red';
      
    } else {
       
        main.style.display = 'none';

        svgLanguage.classList.remove('rotate-down');
        languageTxt.style.color='black';
        
        
    }
}
function toggleCategories() {
   
    var svgCategories = document.getElementById('svgCategories');
    var categoriesTxt=document.getElementById('categoriesTxt')
    var main = document.getElementById('categories');
   

    if (main.style.display==='none') {
        
        main.style.display = 'block';
        svgCategories.classList.add('rotate-down');
        categoriesTxt.style.color='red';
      
    } else {
       
        main.style.display = 'none';

        svgCategories.classList.remove('rotate-down');
        categoriesTxt.style.color='black';
        
        
    }
}
function clearCalendar() {
    // Get the calender input element
    var calenderInput = document.getElementById("calender");

    // Clear the value of the calender input field
    calenderInput.value = "";
}


function clearLanguage() {
    // Get all elements with class 'langDiv'
    var langDivs = document.querySelectorAll('.langDiv');
  
    // Reset styles for each 'langDiv'
    langDivs.forEach(function (langDiv) {
      // Set default background color
      langDiv.style.backgroundColor = ''; // This will remove the inline style
  
      // Reset text color for the nested 'langTxt' element
      var langTxt = langDiv.querySelector('.langTxt');
      langTxt.style.color = ''; // This will remove the inline style

      selectedLanguages ={};
     
    });
  }

  function clearCategories() {
    // Get all elements with class 'langDiv'
    var categoriesDivs = document.querySelectorAll('.categoriesDiv');
  
    // Reset styles for each 'categoriesDivDiv'
    categoriesDivs.forEach(function (categoriesDiv) {
      // Set default background color
      categoriesDiv.style.backgroundColor = ''; // This will remove the inline style
  
      // Reset text color for the nested 'categoriesDivTxt' element
      var categoriesDivTxt = categoriesDiv.querySelector('.categryTxt');
      categoriesDivTxt.style.color = ''; // This will remove the inline style
      // Reassign an empty array to the variable
      selectedCategory ={};
      // Now, selectedCategory is an empty array
     
    });
  }
  

  var selectedLanguages = {};

  document.addEventListener('DOMContentLoaded', function () {
      // Get all elements with class 'langDiv'
      var langDivs = document.querySelectorAll('.langDiv');
  
      // Add click event listener to each 'langDiv'
      langDivs.forEach(function (langDiv) {
          langDiv.addEventListener('click', function () {
              // Toggle background color
              this.style.backgroundColor = this.style.backgroundColor === 'red' ? 'white' : 'red';
  
              // Toggle text color for the nested 'langTxt' element
              var langTxt = this.querySelector('.langTxt');
              langTxt.style.color = langTxt.style.color === 'white' ? 'red' : 'white';
  
              // Get the ID of the clicked element
              var selectedId = this.id;
  
              // Toggle the selection status using an object
              if (selectedLanguages[selectedId]) {
                  // ID is already in the object, remove it
                  delete selectedLanguages[selectedId];
              } else {
                  // ID is not in the object, add it
                  selectedLanguages[selectedId] = true;
              }
  
              // Output the selectedLanguages object for testing
              console.log(selectedLanguages);
          });
      });
  });
  

  var selectedCategory = {};

  document.addEventListener('DOMContentLoaded', function () {
      // Get all elements with class 'langDiv'
      var categoriesDivs = document.querySelectorAll('.categoriesDiv');
  
      // Add click event listener to each 'categoriesDiv'
      categoriesDivs.forEach(function (categoriesDiv) {
          categoriesDiv.addEventListener('click', function () {
              // Toggle background color
              this.style.backgroundColor = this.style.backgroundColor === 'red' ? 'white' : 'red';
  
              // Toggle text color for the nested 'categryTxt' element
              var categryTxt = this.querySelector('.categryTxt');
              categryTxt.style.color = categryTxt.style.color === 'white' ? 'red' : 'white';
  
              var selectedId = this.id;
  
              // Toggle the selection status using an object
              if (selectedCategory[selectedId]) {
                  // ID is already in the object, remove it
                  delete selectedCategory[selectedId];
              } else {
                  // ID is not in the object, add it
                  selectedCategory[selectedId] = true;
              }
  
              // Output the selectedCategory object for testing
              console.log(selectedCategory);
          });
      });
  });
  


function filterValues(){
  
  console.log('Selected Languages:', selectedLanguages);
  console.log('Selected Category:',selectedCategory);
  $.ajax({
    type: "POST",
    url: 'components/bookMyShow.cfc?method=event',

    success: function (response) {   
        $("#movieRowDiv").load(location.href + " #movieRowDiv");

        console.log(response);

    },
    error: function (error) {
       console.error("Error changing session variable:", error);
    }
 });
  
    
    
}

