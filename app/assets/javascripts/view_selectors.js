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
