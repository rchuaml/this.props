  // Initialize and add the map
  var map;
  var markers = [];

  function initMap() {
    // The Binding of the infobox
    function bindInfoWindow(marker, map, infowindow, info) {
        marker.addListener('click', function() {
            infowindow.setContent(info);
            infowindow.open(map, this);
        });
    }
    // The location of Singapore
    var sg = {lat: 1.357107, lng: 103.8194992};

    // The map, centered at Sg
    map = new google.maps.Map(document.getElementById('map'), {zoom: 11, center: sg});
    
    plotMarkers(gon.houses);
  };

  function plotMarkers(houses) {
    // Plot Markers
     //icon
    var icon = {
      url: 'https://bravovillas.com/wp-content/uploads/2015/01/map-marker-red-fat.png',
      scaledSize: new google.maps.Size(30, 30)
    };

    for (let i = 0; i < houses.length; i++) {
      var infowindow = new google.maps.InfoWindow();
      var marker = new google.maps.Marker({
        position: {lat: houses[i].lat, lng: houses[i].long},
        map: map,
        icon: icon
      });

      google.maps.event.addListener(marker,'click',function() {
          var infowindow = new google.maps.InfoWindow({
            content: `<h6>Name: ${houses[i].name}</h6><br>Price: ${houses[i].price}<br>Bedrooms: ${houses[i].bedrooms}<br>Bathrooms: ${houses[i].bathrooms}<br>Lease Left: ${houses[i].lease_left}<br><a href="/houses/${houses[i].id}">Click Here For More Details</a>`
          });
          infowindow.open(map, this);
      });
      markers.push(marker);
    };
  };

  function clearMarkers(markers) {
    for (let i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
    };
  };

  //Filter Function
  function filter() {
    //Collect Filter Data
    let minPrice = document.querySelector('#collapseOne > div > div:nth-child(1) > div:nth-child(1) > span:nth-child(1) > input[type="text"]').value;
    let maxPrice = document.querySelector('#collapseOne > div > div:nth-child(1) > div:nth-child(1) > span:nth-child(2) > input[type="text"]').value;
    let minFloorArea = document.querySelector('#collapseOne > div > div:nth-child(1) > div:nth-child(2) > span:nth-child(1) > input[type="text"]').value;
    let maxFloorArea = document.querySelector('#collapseOne > div > div:nth-child(1) > div:nth-child(2) > span:nth-child(2) > input[type="text"]').value;
    let minFloorLevel = document.querySelector('#collapseOne > div > div:nth-child(1) > div:nth-child(3) > span:nth-child(1) > input[type="text"]').value;
    let maxFloorLevel = document.querySelector('#collapseOne > div > div:nth-child(1) > div:nth-child(3) > span:nth-child(2) > input[type="text"]').value;
    let bedrooms = document.querySelector('#bedrooms').innerText;
    let bathrooms = document.querySelector('#bathrooms').innerText;
    let minLeaseLeft = document.querySelector('#leases').innerText;
    let furnish = document.querySelector('#collapseOne > div > div.row.pt-4 > div:nth-child(4) > div:nth-child(2) > div > label > input[type="checkbox"]').checked;
    console.log(furnish);

    //Need to Filter and create a new array of house objects and pass into Plot Markers.
    let filtered = gon.houses.filter( house => {
      return (
        house.price >= parseInt(minPrice) &&
        house.price <= parseInt(maxPrice) &&
        house.floor_area >= parseInt(minFloorArea) &&
        house.floor_area <= parseInt(maxFloorArea) &&
        house.floor_levels >= parseInt(minFloorLevel) &&
        house.floor_levels <= parseInt(maxFloorLevel) &&
        house.bedrooms == parseInt(bedrooms) &&
        house.bathrooms == parseInt(bathrooms) &&
        house.lease_left >= parseInt(minLeaseLeft) && 
        house.furnishing == furnish
      );
    });

    clearMarkers(markers);
    markers = [];
    plotMarkers(filtered);
  };


  //Find My Location
  function nearme() {
    var infoWindow = new google.maps.InfoWindow;
    function handleLocationError(browserHasGeolocation, infoWindow, pos) {
      infoWindow.setPosition(pos);
      infoWindow.setContent(browserHasGeolocation ?
                            'Error: The Geolocation service failed.' :
                            'Error: Your browser doesn\'t support geolocation.');
      infoWindow.open(map);
    }

    function distFromMe(originLat, originLong, targetLat, targetLong) {
      function radians(deg) {
        return (deg * Math.PI)/180
      };
      return (
        6371 * Math.acos(Math.cos(radians(originLat))* Math.cos(radians(targetLat))* Math.cos(radians(targetLong) - radians(originLong))+ Math.sin(radians(originLat))* Math.sin(radians(targetLat)))
      );
    };

    var originLat;
    var originLong;

    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        var pos = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };

        let hereYouAre = "Here You Are!";
  
        originLat = position.coords.latitude;
        originLong = position.coords.longitude;


        var settings = {
          "async": true,
          "crossDomain": true,
          "url": `https://us1.locationiq.com/v1/reverse.php?key=pk.a152695d6750793ce3da9347d9567cdc&q=&lat=${originLat}&lon=${originLong}&format=json`,
          "method": "GET"
        }
        
        $.ajax(settings).done(function (response) {
          hereYouAre = response.display_name;
          infoWindow.setPosition(pos);
          infoWindow.setContent(hereYouAre);
          infoWindow.open(map);
          map.setCenter(pos);
        });
        
        //Houses Within 2km
        let housesNearMe = gon.houses.filter( house => {  
          return distFromMe(originLat, originLong, house.lat, house.long) < 2
        });
    
        clearMarkers(markers);
        markers = [];
        plotMarkers(housesNearMe);
      }, function() {
        handleLocationError(true, infoWindow, map.getCenter());
      });
    } else {
      // Browser doesn't support Geolocation
      handleLocationError(false, infoWindow, map.getCenter());
    };
  };
