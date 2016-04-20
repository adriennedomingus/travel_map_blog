$(document).ready(function(){
  setBackground();
});

function setBackground() {
  var backgroundImage = getImage();
  $('#background').css('background', backgroundImage );
}

function getImage() {
  return "url('https://images.unsplash.com/photo-1460574283810-2aab119d8511?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=8f51973741d4b25375b6bb3de767dd67')";
}
