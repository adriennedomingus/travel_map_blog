$( document ).ready(function() {
  var url = document.URL.split("/")
  if (url[url.length - 1] === "search" && url[url.length - 2] === "blogs") {
    initMap();
    placeBlogSearchMarkers();
  } else if ( $('#map').length > 0 ) {
    initMap();
    placeBlogMarkers();
    placePhotoMarkers();
    setLegend();
    setViewButtons();
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


function setLegend(){
  map.controls[google.maps.ControlPosition.LEFT_BOTTOM].push(
  document.getElementById('legend'));
  var legend = document.getElementById('legend');
  var url = document.URL.split("/")
  var nickname = url[url.length - 1]
  $.getJSON('/trip-colors/' + nickname, function(data){
    $.each(data["trips"], function(key, trip){
      var p = document.createElement('p');
      p.innerHTML =  "<div class='square' id=" + trip.slug + "><style> #" + trip.slug + " { border: 5px solid" + trip.color + "; }</style></div><span class='trip-name'><a href='/users/" + nickname + "/trips/" + trip.slug +"'>" + trip.name + "</a></span>";
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

var blogMarkers = []
function placeBlogMarkers(){
  var nickname = getNickname();
  $.getJSON('/blog-markers/' + nickname, function(data) {
    $.each(data["blogs"], function(key, blog) {
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
      blogMarkers.push(marker);
      google.maps.event.addListener(marker, 'click', function() {
        window.location.href = this.url;
      });
    });
  })
}

function placeBlogSearchMarkers(){
  $("#blog-search").click(function(){
    var location = $("#search_location").val();
    var radius = $("#search_radius").val();
    $.ajax({
      type: "POST",
      url: "/blogs/search?location=" + location + "&radius=" + radius,
      success: function(data) {
        if (data["search"].length === 0) {
          alert("No blogs match your search. Please try a different location or a larger search radius.");
        } else {
          $(".search-form").addClass('hidden')
          $.each(data["search"], function(key, blog) {
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
            map.setZoom(8);
            map.setCenter({lat: parseInt(this.latitude), lng: parseInt(this.longitude)});
            google.maps.event.addListener(marker, 'click', function() {
              window.location.href = this.url;
            });
          })
        }
      }
    });
  });
}

var photoMarkers = []
function placePhotoMarkers(){
  var nickname = getNickname();
  $.getJSON('/photo-markers/' + nickname, function(data) {
    $.each(data["photos"], function(key, photo) {
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
      photoMarkers.push(marker)
      google.maps.event.addListener(marker, 'click', function() {
        window.location.href = this.url;
      });
    });
  })
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

function BlogControl(controlDiv, map) {
  var controlUI = setCSS(controlDiv, map, "Blogs Only");
  controlUI.addEventListener('click', function() {
    setMapOnAllBlog(map);
    clearPhotoMarkers();
  });
}

function PhotoControl(controlDiv, map) {
  var controlUI = setCSS(controlDiv, map, "Photos Only");
  controlUI.addEventListener('click', function() {
    setMapOnAllPhoto(map);
    clearBlogMarkers();
  });
}

function PhotoBlogControl(controlDiv, map) {
  var controlUI = setCSS(controlDiv, map, "Photos & Blogs");
  controlUI.addEventListener('click', function() {
    setMapOnAllBlog(map);
    setMapOnAllPhoto(map);
  });
}

function setMapOnAllBlog(map) {
  for (var i = 0; i < blogMarkers.length; i++) {
    blogMarkers[i].setMap(map);
  }
}

function setMapOnAllPhoto(map) {
  for (var i = 0; i < photoMarkers.length; i++) {
    photoMarkers[i].setMap(map);
  }
}

function clearBlogMarkers() {
  setMapOnAllBlog(null);
}

function clearPhotoMarkers() {
  setMapOnAllPhoto(null);
}

function setViewButtons() {
  var photoBlogControlDiv = document.createElement('div');
  var photoBlogControl = new PhotoBlogControl(photoBlogControlDiv, map);
  photoBlogControlDiv.index = 1;
  map.controls[google.maps.ControlPosition.TOP_CENTER].push(photoBlogControlDiv);

  var blogControlDiv = document.createElement('div');
  var blogControl = new BlogControl(blogControlDiv, map);
  blogControlDiv.index = 1;
  map.controls[google.maps.ControlPosition.TOP_CENTER].push(blogControlDiv);

  var photoControlDiv = document.createElement('div');
  var photoControl = new PhotoControl(photoControlDiv, map);
  photoControlDiv.index = 1;
  map.controls[google.maps.ControlPosition.TOP_CENTER].push(photoControlDiv);
}

function setCSS(controlDiv, map, text) {
  var controlUI = document.createElement('div');
  controlUI.style.backgroundColor = '#fff';
  controlUI.style.border = '2px solid grey';
  controlUI.style.borderRadius = '3px';
  controlUI.style.cursor = 'pointer';
  controlUI.style.marginBottom = '22px';
  controlUI.style.textAlign = 'center';
  controlDiv.appendChild(controlUI);

  var controlText = document.createElement('div');
  controlText.style.color = 'rgb(25,25,25)';
  controlText.style.fontSize = '16px';
  controlText.style.lineHeight = '38px';
  controlText.style.paddingLeft = '5px';
  controlText.style.paddingRight = '5px';
  controlText.innerHTML = text;
  controlUI.appendChild(controlText);
  return controlUI;
}

function getNickname(){
  var url = document.URL.split("/")
  return url[url.length - 1]
}
