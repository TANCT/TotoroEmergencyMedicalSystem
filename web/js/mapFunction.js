/* global google */
let map, infoWindow;//Google Map:global variable
let page = 1; //Paging:global variable

let biggest = 0;
let distanceList = [];

function initMaps() {
    map = new google.maps.Map(document.getElementById("map"), {
        center: { lat: 3.8925533126426664, lng: 102.10080302222984 },
        zoom: 8,
        mapId: 'b7950cd711ebba94'
    });
    infoWindow = new google.maps.InfoWindow();

    const locationButton = document.createElement("button");
    //locationButton.textContent = "Pan to Current Location";
    locationButton.classList.add("custom-map-control-button");
    locationButton.innerHTML = "<img src='images/AEDmarker.png' style='margin:0px 0px 0px 0px;' alt='Your Location' width='100' height='100'>";
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


    //setMarker(map);
    var y = document.getElementsByName('itemLat');
    const img =
    {
        url: 'images/AEDicon.png',
        // This marker is 20 pixels wide by 32 pixels high.
        size: new google.maps.Size(32, 32),
        // The origin for this image is (0, 0).
        origin: new google.maps.Point(0, 0),
        // The anchor for this image is the base of the flagpole at (0, 32).
        anchor: new google.maps.Point(0, 32),
        scaledSize: new google.maps.Size(25, 25)
    };
    for (var i = 0; i < y.length; i++) {
        var x = { lat: parseFloat(document.getElementsByName('itemLat')[i].innerHTML), lng: parseFloat(document.getElementsByName('itemLon')[i].innerHTML) };
        console.log(x);
        var marker = new google.maps.Marker(
            {
                position: x,
                map,
                title: document.getElementsByName('itemName')[i].innerHTML,
                icon: img
            });
        var ifw = new google.maps.InfoWindow({
            content: document.getElementsByName('itemName')[i].innerHTML
        });
        ifw.addListener("click", () => {
            ifw.open({
                anchor: marker,
                map,
                shouldFocus: false
            });
        });

    }

    //Rearrange


}
