<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event</title>
    
</head>
    <body>
        <cfinclude  template="header.cfm">
        <cfobject component="components/bookMyShow" name="objBookMyShow">
        <cfset local.event=objBookMyShow.fetchEventDetails()> 
        


    
    
    </body>
</html>