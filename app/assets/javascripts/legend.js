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
