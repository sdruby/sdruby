
$(document).ready(function() {
  
  $("li.all").click(function() {
    $(".episode").show();
    $("#filter li").removeClass("current");
    $(".all").addClass("current");
  });
  
  $("li.filter_2009").click(function() {
    $(".episode").hide();
    $("#filter li").removeClass("current");
    $(".filter_2009").addClass("current");
    $(".published_in_2009").show();
  });
  
  $("li.filter_2008").click(function() {
    $(".episode").hide();
    $("#filter li").removeClass("current");
    $(".filter_2008").addClass("current");
    $(".published_in_2008").show();
  });
  
  $("li.filter_2007").click(function() {
    $(".episode").hide();
    $("#filter li").removeClass("current");
    $(".filter_2007").addClass("current");
    $(".published_in_2007").show();
  });
  
  $("li.filter_2006").click(function() {
    $(".episode").hide();
    $("#filter li").removeClass("current");
    $(".filter_2006").addClass("current");
    $(".published_in_2006").show();
  });
});