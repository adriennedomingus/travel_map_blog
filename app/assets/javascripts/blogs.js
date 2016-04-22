$(document).ready(function(){
  setBackground();
  $("input[name='trip[color]']").minicolors()
});

function setBackground() {
  var url = document.URL.split("/")
  var slug = url[url.length - 1]
  $.getJSON('/blog-image/' + slug, function(data){
    $('#background').css('background', "url(" + data['image'] + ")");
  })
}
