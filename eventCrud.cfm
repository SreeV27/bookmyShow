<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event</title>
    <link rel="stylesheet" href="style/bootstrap.min.css">
    <link rel="stylesheet" href="style/eventCrud.css">
    
</head>
    <body>
        <cfinclude  template="header.cfm">
        <cfobject component="components/bookMyShow" name="objBookMyShow">
        <cfset local.event=objBookMyShow.fetchEventDetails()>
        <cfoutput>
            <div class="px-5 pt-5 ">
                <div class="d-flex justify-content-between">
                    <h2>Event Details</h2>
                    <button class="addEventBtn mt-1">Add Event</button>

                </div>
                <center>
                    <table class="mt-5 table">
                        <tr>
                            <th>Id</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Location</th>
                            <th>Venue</th>
                            <th>View</th>                    
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>        
                        <cfloop query="local.event">
                            <tr>
                                <td>#local.event.event_id#</td>
                                <td>#local.event.name#</td>
                                <td>#local.event.category#</td>
                                <td>#local.event.location#</td>
                                <td>#local.event.venue#</td>
                                <td><button type="button" class="view border-0 bg-white btn btn-primary" data-eventid="#local.event.event_id#" data-toggle="modal" data-target=".eventModal"><img src="assests/file.png" height="15px" width="15px" alt="Pen Image"></button></td>
                                <td><button type="button" class="edit border-0 bg-white btn btn-primary" data-eventid="#local.event.event_id#" data-toggle="modal" data-target=".eventModal"><img src="assests/pen.png" height="15px" width="15px" alt="Pen Image"></button>
                                </td>
                                
                                <td><button class="border-0 bg-white"><img src="assests/trash.png" height="15px" width="15px" alt="Pen Image"></button></td>
                            </tr>
                        </cfloop>
                    </table>
                </center>             
            </div>            
        </cfoutput>    


        
<!-- Button trigger modal -->

  
  <!-- Modal -->
  <div class="modal fade eventModal"  tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Event Details</h5>
          <button type="button" class="close border-0 bg-white" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="d-flex">
            <label for="eventName">Event name</label>
            <input type="text" id="eventName" required>
          </div>
          <div>
            <label for="date">Date</label>
            <input type="text" id="date" required>
          </div>
          <div>
            <label for="duration">Duration</label>
            <input type="text" id="duration" required>
          </div>
          <div>
            <label for="location">Location</label>
            <input type="text" id="location" required>
          </div>
          <div>
            <label for="venue">Venue</label>
            <input type="text" id="venue" required>
          </div>
          <div>
            <label for="rate">Rate</label>
            <input type="text" id="rate" required>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" id="closeBtn" class="btn btn-secondary" data-dismiss="modal">Close</button>
          <button type="button" id="saveBtn" class="btn btn-primary">Save changes</button>
        </div>
      </div>
    </div>
  </div>
  
  <script src="script/jquery-3.6.4.js"></script>
  <script src="script/popper.js"></script>
  <script src="script/bootstrap.min.js"></script>
  <script src="script/eventCrud.js"></script>

    </body>
</html>