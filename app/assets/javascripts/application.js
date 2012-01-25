$(function () {
  var $all = $(".all"),
      $filter = $("#filter li"),
      $episode = $(".episode"),
      cur = "current";

  $all.click(function () {
    $episode.show();
    $filter.removeClass(cur);
    $all.addClass(cur);
  });

  $(".filter").click(function () {
    var year = $(this).find("span").html();
    $episode.hide();
    $filter.removeClass(cur);
    $(".filter_" + year).addClass(cur);
    $(".published_in_" + year).show();
  });

  if ($('.panel').length) {
    $(':checkbox').iphoneStyle();
  }
});
