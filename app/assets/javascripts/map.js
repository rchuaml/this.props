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
    };
  };


  //Filter Function
  function filter() {
      //Need to Filter and create a new array of house objects and pass into Plot Markers.
      let filtered = gon.houses.filter((val, ind, arr) => {
        return val.bedrooms == 4;
      });


      console.log(filtered)
      clearMarkers();
  };