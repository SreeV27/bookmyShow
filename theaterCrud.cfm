<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Theater</title>
    <link rel="stylesheet" href="style/bootstrap.min.css">
    <link rel="stylesheet" href="style/theaterCrud.css">
    
</head>
    <body>
        <cfinclude  template="header.cfm">
        <cfobject component="components/bookMyShow" name="objBookMyShow">
        <cfset local.theater=objBookMyShow.fetchTheaterDetails()>
        <cfoutput>          
            <div class="px-5 pt-5 ">
                <div class="d-flex justify-content-between">
                    <h2>Theater Details</h2>
                    <button type="button" class="addTheaterBtn mt-1 px-1" id="addTheaterBtn" data-toggle="modal" data-target=".theaterAddModal">Add Theater</button>

                </div>
                <center>
                    <table class="mt-5 table">
                        <tr>
                            <th >Id</th>
                            <th>Name</th>
                            <th>Address</th>
                            <th>Location</th>
                            <th>Ph No</th>
                            <th>View</th>
                            <th>Edit</th>
                            <th>Delete</th>

                        </tr>        
                        <cfloop query="local.theater">
                            <tr>
                                <td >#local.theater.id#</td>
                                <td>#local.theater.name#</td>
                                <td>#local.theater.address#</td>
                                <td>#local.theater.location#</td>
                                <td>#local.theater.phno#</td>
                                <td><button type="button" class="view border-0 bg-white btn btn-primary" data-theaterid="#local.theater.id#" data-toggle="modal" data-target=".theaterModal"><img src="assests/file.png" height="15px" width="15px" alt="view"></button></td>
                                <td><button type="button" class="edit border-0 bg-white btn btn-primary" data-theaterid="#local.theater.id#" data-toggle="modal" data-target=".theaterModal"><img src="assests/pen.png" height="15px" width="15px" alt="Edit"></button></td>                                
                                <td><button type="button" class="deleteTheaterBtn border-0 bg-white"  data-theaterid="#local.theater.id#"><img src="assests/trash.png" height="15px" width="15px" alt="Delete"></button></td>
                            </tr>
                        </cfloop>
                    </table>
                </center>             
            </div>            
        </cfoutput>   
        <!-- View Modal -->
        <div class="modal fade theaterModal" id="theaterModal" data-backdrop="static"  tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
            <div class="modal-content ">
                <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Theater Details</h5>
                <button type="button" class="close border-0 bg-white" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                </div>
                <div class="modal-body pe-5">
                                
                    <div class="d-flex justify-content-between ps-4">
                        <label for="theaterName">Name</label>
                        <div class="">
                            <input type="text"id="theaterName" required>
                        </div>
                    </div>                    
                    <div class="mt-2 d-flex justify-content-between ps-4">
                    <label for="address">Address</label>
                        <div class="">
                            <textarea id="address" name="address" rows="4" cols="21"></textarea>
                        </div>
                    </div>                
                    <div class="mt-2 d-flex px-4">
                        <label for="location">Location</label>
                        <div class=" ms-5 p-20">
                            <select id="location"  required></select>
                        </div>
                    </div>
                    <div class="mt-2 d-flex justify-content-between ps-4">
                        <label for="phno">Ph no</label>
                        <div class="">
                            <input type="text" id="phno" required>
                        </div>
                    </div>
                    <div class="mt-2 d-flex justify-content-between ps-4">
                        <label for="time">Theater Time</label>
                        <div class="">
                            <textarea id="time" name="time" rows="4" cols="22"></textarea>
                        </div>
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
        <script src="script/theaterCrud.js"></script>
    </body>
</html>