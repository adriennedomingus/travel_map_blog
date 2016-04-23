$( document ).ready(function() {
  initMap();
  placeBlogMarkers();
  placePhotoMarkers();
  setLegend();
});

var map;
function initMap() {
  var myLatLng = {lat: -25.363, lng: 131.044};
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 50.0, lng: 0},
    zoom: 2
  });
}

function setLegend(){
  map.controls[google.maps.ControlPosition.LEFT_BOTTOM].push(
  document.getElementById('legend'));
  var legend = document.getElementById('legend');
  var url = document.URL.split("/")
  var nickname = url[url.length - 1]
  $.getJSON('/trip-colors/' + nickname, function(data){
    $.each(data, function(key, trip){
      var p = document.createElement('p');
      p.innerHTML =  "<div class='square' id=" + trip.slug + "><style> #" + trip.slug + " { border: 5px solid" + trip.color + "; }</style></div><span class='trip-name'>" + trip.name + "</span>";
      legend.appendChild(p);
    })
  })
  var blogLink = document.createElement('p');
  blogLink.innerHTML =  "<a href='/users/" + nickname + "/blogs'>All Blogs</a>";
  legend.appendChild(blogLink);
  var photoLink = document.createElement('p');
  photoLink.innerHTML =  "<a href='/users/" + nickname + "/photos'>All Photos</a>";
  legend.appendChild(photoLink);
  var tripLink = document.createElement('p');
  tripLink.innerHTML =  "<a href='/users/" + nickname + "/trips'>All Trips</a>";
  legend.appendChild(tripLink);
}

function placeBlogMarkers(){
  var url = document.URL.split("/")
  var nickname = url[url.length - 1]
  $.getJSON('/blog-markers/' + nickname, function(data) {
    $.each(data, function(key, blog) {
      var pinColor = setPinColor(blog);
      var marker = new google.maps.Marker({
        position: {lat: parseFloat(blog.latitude), lng: parseFloat(blog.longitude)},
        map: map,
        icon: {
                  path: google.maps.SymbolPath.BACKWARD_CLOSED_ARROW,
                  scale: 4,
                  strokeWeight:3,
                  strokeColor: pinColor,
               },
        url: "/blogs/" + blog.slug
      });
      google.maps.event.addListener(marker, 'click', function() {
        window.location.href = this.url;
      });
    });
  })
}

function placePhotoMarkers(){
  var url = document.URL.split("/")
  var nickname = url[url.length - 1]
  $.getJSON('/photo-markers/' + nickname, function(data) {
    $.each(data, function(key, photo) {
      var pinColor = setPinColor(photo);
      var marker = new google.maps.Marker({
        position: {lat: parseFloat(photo.latitude), lng: parseFloat(photo.longitude)},
        map: map,
        icon: {
              path: google.maps.SymbolPath.CIRCLE,
              scale: 5,
              strokeColor: pinColor,
              },
        url: "/photos/" + photo.id
      });
      google.maps.event.addListener(marker, 'click', function() {
        window.location.href = this.url;
      });
    });
  })
}

function setPinColor(blog){
  if(blog.color) {
    return blog.color;
  } else {
    return "#FE7569";
  }
}
