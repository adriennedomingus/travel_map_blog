$(document).ready(function(){
  setBackground();
});

function setBackground() {
  var url = document.URL.split("/")
  var slug = url[url.length - 1]
  $.getJSON('/blog-image/' + slug, function(data){
    debugger
    $('#background').css('background', "url(" + data['image'] + ")");
  })
}
