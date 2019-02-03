console.log(gon.houses)

function initMap() {
    listOfCoodinate = []
    lisfOfMarker = []
    listOfContentString = []
    listOfInfowindow = []

    for (let i = 0; i < gon.houses.length; i++) {
        let myLatLng = {lat: Number(gon.houses[i].latitude), lng: Number(gon.houses[i].longitude)};
        listOfCoodinate.push(myLatLng)
    }

    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 11.7,
        center: {lat: 1.380, lng: 103.8198}
    });

    for (let i = 0; i < gon.houses.length; i++) {
        let div = document.createElement("div");

        let name = document.createElement("h4");
        let newContent1 = document.createTextNode("Name: " + gon.houses[i].name);
        name.appendChild(newContent1);

        let location = document.createElement("h5");
        let newContent2 = document.createTextNode("Location: " + gon.houses[i].location);
        location.appendChild(newContent2);

        let price = document.createElement("h5");
        let newContent3 = document.createTextNode("Price: $" + gon.houses[i].price);
        price.appendChild(newContent3);

        let bedroom = document.createElement("h5");
        let newContent4 = document.createTextNode("Bedroom: " + gon.houses[i].bedrooms);
        bedroom.appendChild(newContent4);

        let floorArea = document.createElement("h5");
        let newContent5 = document.createTextNode("Floor Area: " + gon.houses[i].floor_area);
        floorArea.appendChild(newContent5);

        let floorLevel = document.createElement("h5");
        let newContent6 = document.createTextNode("Floor Level: " + gon.houses[i].floor_levels);
        floorLevel.appendChild(newContent6);

        div.appendChild(name);
        div.appendChild(location);
        div.appendChild(price);
        div.appendChild(bedroom);
        div.appendChild(floorArea);
        div.appendChild(floorLevel);

        listOfContentString.push(div);
    }


    for (let i = 0; i < gon.houses.length; i++) {
        let infowindow = new google.maps.InfoWindow({
            content: listOfContentString[i]
        });
        listOfInfowindow.push(infowindow);
    }

    for (let i = 0; i < gon.houses.length; i++) {
        let  marker = new google.maps.Marker({
            position: listOfCoodinate[i],
            map: map,
        });
        marker.addListener('click', function() {
            listOfInfowindow[i].open(map, marker);
        });
        lisfOfMarker.push(marker);
    }

}