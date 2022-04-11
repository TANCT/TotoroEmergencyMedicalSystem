<%-- 
    Document   : createContact
    Created on : Dec 22, 2021, 3:52:26 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="../../css/page.css">
        <link rel="stylesheet" href="../../css/style.css">
        <link href="https://fonts.googleapis.com/css2?family=Pushster&display=swap" rel="stylesheet">
        <script async defer src="https://maps.googleapis.com/maps/api/js?libraries=places&key=AIzaSyDpVOyIXm_sprexK7xpy9f5KYSv_wPLPh0&callback=initMap"></script>
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"  crossorigin="anonymous">
            
	</script>
        <script>
             $(document).ready(function(){
                
                $("#refresh").load("/TotoroEmergencyMedical/header.jsp");
            setInterval(function(){
                  $("#refresh").load("/TotoroEmergencyMedical/header.jsp");
            }, 3000);
            });
             google.maps.event.addDomListener(window, 'load', initMap);
           
           
            function initMap() {
                var map = new google.maps.Map(document.getElementById('map'), {
                  center: {lat: -33.8688, lng: 151.2195},
                  zoom: 13
                });
                if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position) {
                  initialLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
                  map.setCenter(initialLocation);
                  // creates a marker of user's location
                  var marker = new google.maps.Marker({
                    position: initialLocation,
                    map: map,
                    title: 'Your Location'
                  });
                  find(marker.getPosition());
                }, function(error) { console.log(error)
                });
              }
            
                var input = document.getElementById('searchInput');
                //map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

                var autocomplete = new google.maps.places.Autocomplete(input);
                autocomplete.bindTo('bounds', map);

                var infowindow = new google.maps.InfoWindow();
                var marker = new google.maps.Marker({
                    map: map,
                    anchorPoint: new google.maps.Point(0, -29),
                    draggable:true
                });

                autocomplete.addListener('place_changed', function() {
                    infowindow.close();
                    marker.setVisible(false);
                    var place = autocomplete.getPlace();
                    if (!place.geometry) {
                        window.alert("Autocomplete's returned place contains no geometry");
                        return;
                    }

                    // If the place has a geometry, then present it on a map.
                    /*if (place.geometry.viewport) {
                        map.fitBounds(place.geometry.viewport);
                    } else {
                        map.setCenter(place.geometry.location);
                        map.setZoom(17);
                    }*/
                    marker.setIcon(({
                        url: place.icon,
                        size: new google.maps.Size(71, 71),
                        origin: new google.maps.Point(0, 0),
                        anchor: new google.maps.Point(17, 34),
                        scaledSize: new google.maps.Size(35, 35)
                    }));
                    marker.setPosition(place.geometry.location);
                    marker.setVisible(true);
                    
                    var address = '';
                    if (place.address_components) {
                        address = [
                          (place.address_components[0] && place.address_components[0].short_name || ''),
                          (place.address_components[1] && place.address_components[1].short_name || ''),
                          (place.address_components[2] && place.address_components[2].short_name || '')
                        ].join(' ');
                    }

                    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
                    infowindow.open(map, marker);

                    // Location details
                    for (var i = 0; i < place.address_components.length; i++) {
                        if(place.address_components[i].types[0] === 'postal_code'){
                            document.getElementById('postal_code').innerHTML = place.address_components[i].long_name;
                        }
                        if(place.address_components[i].types[0] === 'country'){
                            document.getElementById('country').innerHTML = place.address_components[i].long_name;
                        }
                    }
                    document.getElementById('location').innerHTML = place.formatted_address;
                    document.getElementById('lat').innerHTML = place.geometry.location.lat();
                    document.getElementById('lon').innerHTML = place.geometry.location.lng();
                });
                
            }
            
            function paste(){
                var lat=document.getElementById("lat");
                var lon=document.getElementById("lon");
                document.getElementById("latitude").value=""+lat.innerHTML;
                document.getElementById("longitude").value=""+lon.innerHTML;
            }
               
           
           
            </script>
            <style>
                .con{
                    display:flex;
                    flex-direction: column;
                    justify-content: space-around;
                    align-content: center;
                    align-items: center;
                    
                }
                 #map{
                
                width: 80%;
                height: 200px;
                align:center;
               
            }
            .controls{
               display:block;
               width:60%;
               align:center;
            }
            .input{
                width:600px;
                display:flex;
                justify-content: center;
                
            }
            h1{
                text-align: center;
            }
            #geo-data{
                
                border:none;
                width:60%;
            }
            #geo-data tr,th,td{
                border:none;
                text-align: left;
                font-size:20px;
            }
            #geo-data td{
                width:80%;
            }
            table{
                border:none;
                width:400px;
            }
            .createform{
                width:300px;
                border:none;
                
            }
           
            .createform th{
                width:30px;
                text-align: left;
            }
            .createform td{
                width:80%;
            }
            .create-form th,td{
                border:none;
                font-size:20px;
            }
            input{
                padding:5px;
            }
            input[type=submit]{
                padding:10px;
                background-color:#00b2ff;
                color:white;
                width:90px;
                border:2px solid white;
                font-size:18px;
               
                
            }
            #center{
                display:flex;
                justify-content: center;
            }
            button{
                padding:10px;
                background-color:#00b2ff;
                color:white;
                width:280px;
                border:2px solid white;
                font-size:18px;
            } 
            h1{
                font-size:30px;
                font-family: 'Pushster', cursive;
                color:#ff4500;
            }
            
            </style>
    </head>
    <body>
        <%if(session.getAttribute("usertype")==null){%>
        <script>alert('Please Login First');location.href='/TotoroEmergencyMedical/login.jsp';</script>
            <%
        }else if(!session.getAttribute("usertype").equals("admin")){%>
        <script>alert('Only Admin can access');location.href='/TotoroEmergencyMedical/login.jsp'</script><%}else{%>
        <div id="refresh"></div>
         
        <div class='con' >
            <h1>Create Emergency Contact</h1>
            <br>
        <div class="input">
        <input id="searchInput" class="controls" type="text" placeholder="Enter a location" />
        </div>
            <br>  
        <div id="map" ></div>
        
        <br>
       
        <table id="geo-data" >
            <tr>
                <th>Full Address</th>
                <td><span id="location"></span></td>
            </tr>
            <tr>
                <th>Postal Code</th>
                <td><span id="postal_code"></span></td>
            </tr>
            <tr>
                <th>Country</th>
                <td><span id="country"></span></td>
            </tr>
            <tr>
                <th>Latitude</th>
                <td><span id="lat"></span></td>
            </tr>
            <tr>
                <th>Longitude</th>
                <td><span id="lon"></span></td>
            </tr>
        </table><br>
        <button id="copy" type="button" onclick="paste()">Insert Latitude and Longitude</button>
          
        <br>
        <h1>New Hospital Contact</h1>
        <br>
        
        <form action="/TotoroEmergencyMedical/hospitalController" method="post">
            <input type='hidden' name='action' value='create'>
            <table class='create-form' >
                <tr>
                    <th>Name</td>
                    <td><input type="text"  name="name"></td>
                </tr>
                <tr>
                    <th>Contact No</td>
                    <td><input type="text" name="phone"></td>
                </tr>
                <tr>
                    <th>Latitude</td>
                    <td><input type="text" name="lat" id="latitude"></td>
                </tr>
                <tr>
                    <th>Longitude</td>
                    <td><input type="text" name="lon" id="longitude"></td>
                </tr>
            </table>
            
            <br>
           
            <div id="center">
            <input type="submit" value="Submit">
            </div>
        </form>
        
        </div>
        <jsp:include page="../../footer.jsp" />  
        <%}%>
    </body>
</html>
