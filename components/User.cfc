<!--- User.cfc --->
<cfcomponent persistent="true"  entityname="userDetail" table="userDetail"> 
    <cfproperty name="id" generator="increment" type="numeric">     
    <cfproperty name="firstname"> 
    <cfproperty name="lastname"> 
    <cfproperty name="dob" type="date">
    <cfproperty name="address">    
    <cfproperty name="postalcode"> 
    <cfproperty name="email"> 
    <cfproperty name="phone">
    
</cfcomponent>
