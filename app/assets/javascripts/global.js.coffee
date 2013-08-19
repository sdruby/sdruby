$(document).ready ->

  # Lazy load podcast episode thumbnails
  $("img.lazy").lazyload()

  # Add iPhone style checkboxes
  if $(".panel").length
    $(":checkbox").iphoneStyle
      checkedLabel: "YES"
      uncheckedLabel: "NO"

  # Filter episodes
  $all = $(".all")
  $filter = $("#filter li")
  $episode = $(".episode")
  cur = "current"
  $all.click ->
    $episode.show()
    $filter.removeClass cur
    $all.addClass cur

  $(".filter").click ->
    year = $(this).find("span").html()
    $episode.hide()
    $filter.removeClass cur
    $(".filter_" + year).addClass cur
    $(".published_in_" + year).show()
    $("#filter input").val ""
    $('img.lazy').lazyload()
    
  # Search Filtering
  $('form.search').each (i, form) ->
    $form      = $(form)
    action     = $form.attr('action') + '.json'
    $query     = $('[name="query"]', form)
    $loading   = $('.loading', form).hide()
    $results   = $('.result')
    $noResults = $('#noresults')

    $form.bind 'submit', (e) =>
      e.preventDefault()
      query = $query.val()

      if query != $form.data('query')
        $form.data('query', query)

        if query == ''
          $results.show()
          $noResults.hide()
        else
          $loading.show()
          $.getJSON action, { q: query }, (data) ->
            $loading.hide()
            $results.hide()

            if data.length
              $noResults.hide()
            else
              $noResults.show()
              
            $.each data, (key, val) -> $(".result[data-id='#{val.id}']").show()

    $query.bind 'keyup', (e) =>  
      clearTimeout(@searchTimeout)
      submitForm = => $form.submit()
      @searchTimeout = setTimeout submitForm, 250

`!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");`
