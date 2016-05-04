$( document ).ready(function() {
  var url = document.URL.split("/")
  if (url[url.length - 1] === "search" && url[url.length - 2] === "blogs") {
    placeBlogSearchMarkers();
  } else if (url[url.length - 1] === "search" && url[url.length - 2] === "photos") {
    placePhotoSearchMarkers();
  } else if ( $('#map').length > 0 ) {
    $(".new-search").addClass("hidden")
    placeBlogMarkers("blog");
    placePhotoMarkers("photo");
    setViewButtons();
    setLegend();
  }
});

var map;
function initMap() {
  var myLatLng = {lat: -25.363, lng: 131.044};
  map = new google.maps.Map(document.getElementById("map"), {
    center: {lat: 50.0, lng: 0},
    zoom: 2
  });
}


var blogMarkers = []
function placeBlogMarkers(){
  var nickname = getNickname();
  $.getJSON('/blog-markers/' + nickname, function(data) {
    $.each(data["blogs"], function(key, blog) {
      var pinColor = setPinColor(blog);
      var marker = createBlogMarker(blog, pinColor);
      blogMarkers.push(marker);
      addMarkerListener(marker);
    });
  })
}

function placeBlogSearchMarkers(){
  $("#blog-search").click(function(){
    var location = $("#search_location").val();
    var radius = $("#search_radius").val();
    placeSearchMarkers("blog", location, radius, ".new-blog-search");
  });
}

function placeSearchMarkers(type, location, radius, newSearchButton) {
  $.ajax({
    type: "POST",
    url: "/" + type + "s/search?location=" + location + "&radius=" + radius,
    success: function(data) {
      if (data["search"].length === 0) {
        alert("No" + type + "s match your search. Please try a different location or a larger search radius.");
      } else {
        $("." + type + "-search-form").addClass('hidden')
        $.each(data["search"], function(key, type) {
          var pinColor = setPinColor(type);
          var marker = createBlogMarker(type, pinColor);
          $(newSearchButton).removeClass("hidden");
          map.setZoom(8);
          map.setCenter({lat: parseInt(this.latitude), lng: parseInt(this.longitude)});
          addMarkerListener(marker);
        })
      }
    }
  });
}

function createBlogMarker(blog, pinColor) {
  return new google.maps.Marker({
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
}

function placePhotoSearchMarkers(){
  $("#photo-search").click(function(){
    var location = $("#search_location").val();
    var radius = $("#search_radius").val();
    $.ajax({
      type: "POST",
      url: "/photos/search?location=" + location + "&radius=" + radius,
      success: function(data) {
        if (data["search"].length === 0) {
          alert("No photos match your search. Please try a different location or a larger search radius.");
        } else {
          $(".photo-search-form").addClass('hidden')
          $.each(data["search"], function(key, photo) {
            var pinColor = setPinColor(photo);
            var marker = createPhotoMarker(photo, pinColor);
            $(".new-photo-search").removeClass("hidden");
            map.setZoom(8);
            map.setCenter({lat: parseInt(this.latitude), lng: parseInt(this.longitude)});
            addMarkerListener(marker);
          })
        }
      }
    })
  });
}

var photoMarkers = []
function placePhotoMarkers(){
  var nickname = getNickname();
  $.getJSON('/photo-markers/' + nickname, function(data) {
    $.each(data["photos"], function(key, photo) {
      var pinColor = setPinColor(photo);
      var marker = createPhotoMarker(photo, pinColor);
      photoMarkers.push(marker)
      addMarkerListener(marker);
    });
  })
}

function addMarkerListener(marker) {
  google.maps.event.addListener(marker, 'click', function() {
    window.location.href = this.url;
  });
}

function createPhotoMarker(photo, pinColor) {
  return new google.maps.Marker({
    position: {lat: parseFloat(photo.latitude), lng: parseFloat(photo.longitude)},
    map: map,
    icon: {
          path: google.maps.SymbolPath.CIRCLE,
          scale: 5,
          strokeColor: pinColor,
        },
    url: "/user/" + photo.user.nickname +"/photos/" + photo.slug
  });
}

function setPinColor(blog){
  if(blog.trip) {
    return blog.trip.color;
  } else if (blog.blog) {
    return blog.blog.color
  } else {
    return "#FE7569";
  }
}

function getNickname(){
  var url = document.URL.split("/")
  return url[url.length - 1]
}
