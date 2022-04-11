<%-- 
    Document   : addAED
    Created on : Dec 24, 2021, 3:36:20 PM
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register AED Location</title>
        
        <style><%@include file="/css/page.css" %></style>
        <style><%@include file="/css/style.css" %></style>
        
    </head>
    <body style="margin:auto auto; text-align: center;width:100%;">
    <jsp:include page="../header.jsp" />  
        <h1>Register an AED</h1>
        <form method="post" action="../aedController">
            <br>
        <p>Latitude <input type="text" id="la" name="la"></p>
        <br>
        <p>Longitude <input id="long" type="text" name="long"></p>
        <br>
        
        <div id="map" style="width:800px;height:500px;margin:20px auto 20px auto">
    <script>
        //let map, infoWindow;

       function initMap() {
    map = new google.maps.Map(document.getElementById("map"), {
        center: { lat: 3.8925533126426664, lng: 102.10080302222984 },
        zoom: 8,
        mapId: 'b7950cd711ebba94'
    });
    infoWindow = new google.maps.InfoWindow();

    const locationButton = document.createElement("button");
    //locationButton.textContent = "Pan to Current Location";
    locationButton.classList.add("custom-map-control-button");
    locationButton.innerHTML = "<img src='../images/AEDmarker.png' style='margin:0px 0px 0px 0px;' alt='Your Location' width='100' height='100'>";
    locationButton.style.marginTop = "0px";
    locationButton.style.padding = '0px 0px 0px 0px';

    locationButton.style.backgroundColor = "transparent";
    locationButton.style.border = 'unset';
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(locationButton);
    locationButton.addEventListener("click", () => {
        // Try HTML5 geolocation.
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                (position) => {
                    const pos = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude
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
        } else {
            // Browser doesn't support Geolocation
            handleLocationError(false, infoWindow, map.getCenter());
        }
    });
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
        function getLatLon(position) {
            var latitude = position.coords.latitude;
            var longitude = position.coords.longitude;
            document.getElementById("la").value=latitude;
            document.getElementById("long").value=longitude;
        }

    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCF299Nac24chSlt35w2AVH1avYXu5fS-E&maps_ids=b7950cd711ebba94&callback=initMap"></script> 
</div>
        <input type="hidden" name="action" value="ADD">
        
        <input type="submit" value="Register">
        </form>
        <jsp:include page="../footer.jsp" />  
    </body>
</html>
