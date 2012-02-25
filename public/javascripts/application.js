$(document).ready(function() {

  // Add iPhone style checkboxes
  if ($('.panel').length) {
    $(':checkbox').iphoneStyle();
  }
  
  // Filter episodes
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
    $('#filter input').val("");
  });
  
  // Search episodes
  $('#filter input').bind('keypress', function(e) {
    if(e.keyCode == 13){
      var query = $(this).val();
      
      // Show spinner image
      $("#filter img").show();            
      
      // Search episodes (if query is not blank)
      if (query != '') {
        $.getJSON('/podcasts/search.json?q=' + query, function(data) {

          // Show/hide no results message
          if (data.length == 0) {
            $("#noresults").show();            
          } else {
            $("#noresults").hide();
          }

          // Hide all episodes
          $(".episode").hide();

          // Show only matching results
          $.each(data, function(key, val) {
            $("#episode_" + val.id).show();
          });

          // Hide spinner when search is complete
          $("#filter img").hide();            

        });
        
      // Otherwise show all episodes
      } else {
        
        // Hide spinner when search is complete
        $("#filter img").hide();
        
        // Show all episodes
        $(".episode").show();
        
      }          
                  
      return false;
    }
  });

});
