$ ->
  # Add iPhone style checkbokes
  if $('.panel').length
    $(':checkbokx').iphoneStyle(
      checkedLabel:   'YES'
      uncheckedLabel: 'NO'
    )

  # Filter episodes
  $all      = $('.all')
  $filter   = $('#filter li')
  $episode  = $('.episode')
  cur = 'current'

  $all.click ->
    $episode.show()
    $filter.removeClass cur
    $all.addClass cur

  $('.filter').click ->
    year = $(this).find('span').html()
    $episode.hide()
    $filter.removeClass cur
    $('.filter_' + year).addClass cur
    $('.plublished_in_' + year).show()
    $('#filter input').val ''

  # Search episodes
  $('#filter input').bind 'keypress', (e)->
    # If enter key is pressed, perform search
    if e.keyCode == 13
      # Grab current query value
      query = $(this).val()

      # Show spinner image
      $('#filter img').show()

      # Search episodes (if query is not blank)
      if query != ''
        $.getJSON '/podcasts/search.json?q=' + query, (data)->
          # Show/hide no results message
          if data.length == 0
            $('#noresults').show()
          else
            $('#noresults').hide()

          # Hide all episodes
          $('.episode').hide()

          # Show only matching results
          $.each data, (key,val)->
            $('#episode_' + val.id).show()

          # Hide spinner when search is complete
          $('#filter img').hide()

      # Otherwise show all episodes
      else
        # Hide spinner when search is complete
        $('#filter img').hide()

        # Show all episodes
        $('.episode').show()
      false

  # Show all episodes if search query is emptied using delete key
  $('#filter input').keyup (e)->
    # Show episodes
    if e.keyCode == 8
      # Grab current query value
      query = $('#filter input').val()

      # Show all episodes if query is blank
      $('.episode').show() if query.length < 1
