$( document ).ready(function() {
  initMap();
  placeMarkers();
});

var map;
function initMap() {
  var myLatLng = {lat: -25.363, lng: 131.044};
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 50.0, lng: 0},
    zoom: 2
  });
}

function placeMarkers(){
  var url = document.URL.split("/")
  var nickname = url[url.length - 1]
  $.ajax({
    url: '/blog-markers/' + nickname,
    success: function(data) {
      $.each(data, function(key, blog) {
        if(blog.color) {
          var pinColor = blog.color
        } else {
          var pinColor = "FE7569"
        }
        var marker = new google.maps.Marker({
          position: {lat: parseFloat(blog.latitude), lng: parseFloat(blog.longitude)},
          map: map,
          icon: "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + pinColor,
          url: "/blogs/" + blog.slug
        });
        google.maps.event.addListener(marker, 'click', function() {
          window.location.href = this.url;
        });
      });
    }
  });
}
