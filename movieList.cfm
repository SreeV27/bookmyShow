<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MovieList</title>
    <link rel="stylesheet" href="style/movieList.css">
    <link rel="stylesheet" href="style/bootstrap.css">
</head>
<body>

    <cfobject component="components/bookMyShow" name="myComponent">
    <cfinclude  template="header.cfm">
    <cfinclude  template="slide.cfm">
    <h1 class="ms-5 ps-5 w-75 heading-txt">Movies</h1>
    
   
   <div class="">
        <div class="movieRowDiv">
            <a href="https://in.bookmyshow.com/mumbai/movies/animal/ET00311762" class="movieDiv">
                <div class=" movieDetailsDiv">                
                    <div width="100%" height="100%" data-content="Animal" class="profilePicDiv">
                        <div class=" imgLink">
                            <img src="assests/antony-profile.jpg" alt="Animal" width="100%" height="100%">
                        </div>
                    </div>
                    <div class="movieNameDiv" style="">
                        <div class=" name-txt">
                            <div class="sc-7o7nez-0 hGuczM">Animal</div>
                        </div>
                        <div class="name-txt"><div class="sc-7o7nez-0 ifFqly">A  </div>
                    </div>
                    <div class=" name-txt">
                        <div class="lang-txt">Hindi, Telugu, Tamil, Kannada, Malayalam</div>
                    </div>
                
                </div>
            </div>
        </a>
        


   </div>
</body>
</html>