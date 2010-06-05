
$(document).ready(function() {
  
  $("li.all").click(function() {
    $(".episode").show();
    $("#filter li").removeClass("current");
    $(".all").addClass("current");
  });
  
  $("li.filter").click(function() {
    year = $(this).find("span").html();
    $(".episode").hide();
    $("#filter li").removeClass("current");
    $(".filter_" + year).addClass("current");
    $(".published_in_" + year).show();
  });
  
  if ( $('.panel').length > 0 )
    $(':checkbox').iphoneStyle();
  
});