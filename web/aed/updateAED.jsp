<%-- 
    Document   : updateAED
    Created on : Dec 24, 2021, 10:28:16 PM
    Author     : USER
--%>

<%@page import="java.util.Vector"%>
<%@page import="com.model.aed"%>
<%@page import="com.model.user"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
        String id=request.getParameter("id");
        /*String query="";
        String driver="com.mysql.jdbc.Driver";           
        String dbName="totoro";
        String url="jdbc:mysql://localhost/"+dbName+"?";
        String userName="root";
        String password="";          
        Class.forName(driver);
        Connection con=DriverManager.getConnection(url,userName,password);
        query="SELECT * from aed where id="+id;
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(query);*/
        //st.executeUpdate(query);
        int itemID = Integer.parseInt(id);
        Vector<user> userSessionList = (Vector<user>)session.getAttribute("userList");
            Vector<aed> aedSessionList = (Vector<aed>)session.getAttribute("list");
        //while(rs.next()){
        aed newAED = new aed();
        user newUser = new user();
        for(int i=0;i<aedSessionList.size();i++){
            if(aedSessionList.elementAt(i).getId()==itemID){
                newAED = aedSessionList.elementAt(i);
                newUser = userSessionList.elementAt(i);
            }
        }
        if(newAED==null){
    %>
    <h2>No AED Selected.</h2>
    <%
        }else{
        %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit AED</title>
        <style><%@include file="/css/page.css" %></style>
        <style><%@include file="/css/style.css" %></style>
        <style>
            .edit{
                background-color:cyan; 
                border-radius: 20px;
                width:70px;
                height:40px;
                font-weight: bold; 
                border-color: white;
            }
            .switch {
  position: relative;
  display: inline-block;
  width: 150px;
  height: 34px;
}

.switch input { 
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 26px;
  width: 26px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}
.slider .number {
  background: none;
  font-size: 14px;
  left: 9px;
  top: 9px;
}
input:checked + .slider {
  background-color: #2196F3;
}

input:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(50px);
  -ms-transform: translateX(50px);
  transform: translateX(120px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}
        </style>
        <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
    </head>
    
    
    <body style="text-align:center;">
        <jsp:include page="../header.jsp" />  
        <h1>Edit AED Location</h1>
        <br>
        
        <form action="../aedController" method="post">
            <input value="<%= newAED.getId() %>" name="id" hidden>
            Latitude: <input value="<%= newAED.getLatitude() %>" name="lat" id="la">
            <br><br>
            Longitude <input value="<%= newAED.getLongitude() %>" name="long" id="long">
            <br><br>
            <label class="switch">
                <input type="checkbox" name="newStatus" id="slide">
                <span class="slider round">
                        <label class="number" id="state">Inactive</label>
                </span>
            </label>
            <br>
            <br>
              <div id="map" style="width:800px;height:500px;margin:20px auto 20px auto">
    <script>
        //let map, infoWindow;
function initMap() {
    map = new google.maps.Map(document.getElementById("map"), {
        center: { lat: 3.8925533126426664, lng: 102.10080302222984  },
        zoom: 8,
        mapId: 'b7950cd711ebba94'
    });
    infoWindow = new google.maps.InfoWindow();
    
}
var options = {
    enableHighAccuracy: true,
    timeout: 5000,
    maximumAge: 0
};
function error(err) {
    console.warn(`ERROR(${err.code}): ${err.message}`);
}
 function getLatLon(position){
            var latitude = position.coords.latitude;
            var longitude = position.coords.longitude;
            document.getElementById("la").value=latitude;
            document.getElementById("long").value=longitude;
 map = new google.maps.Map(document.getElementById("map"), {
        center: { lat: 3.8925533126426664, lng: 102.10080302222984 },
        zoom: 8,
        mapId: 'b7950cd711ebba94'
    });
 infoWindow = new google.maps.InfoWindow();
if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                (position) => {
                    const pos = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude,
                    };
                    infoWindow.setPosition(pos);
                    infoWindow.setContent("Location found.");
                    infoWindow.open(map);
                    map.setCenter(pos);
                },
                () => {
                    handleLocationError(true, infoWindow, map.getCenter());
                }
            );
        }
        }
        function handleLocationError(browserHasGeolocation, infoWindow, pos) {
            infoWindow.setPosition(pos);
            infoWindow.setContent(
                browserHasGeolocation
                    ? "Error: The Geolocation service failed."
                    : "Error: Your browser doesn't support geolocation."
            );
            infoWindow.open(map);
        }
		navigator.geolocation.getCurrentPosition(getLatLon);

    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCF299Nac24chSlt35w2AVH1avYXu5fS-E&maps_ids=b7950cd711ebba94&callback=initMap"></script> 
</div>
            <input type="hidden" name="action" value="UPDATE">
            <input type="submit" value="Update" class="edit">
        </form>
                <script>
                    $("#slide").click(function() {
                    if($(this).is(":checked")){
                        //$("#state").html("Inactive");
                        $("#state").html("Active");
                    }else{
                        $("#state").html("Inactive");
                    }
                });
                </script>
       
    </body>
     
</html>
<%
                }
                //session.setAttribute("editAED",newAED);
                %>
