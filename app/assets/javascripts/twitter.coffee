guarded_ready ->
  twitterContainer = $('.twitter')
  if twitterContainer.length > 0
    $.get('/api/twitter.json', (data) ->
      twitterList = "<ul class='list-group'>"
      $.each(data[0..5], (index, value) ->
        tweet = "<li class='list-group-item'>
          <div class='row'>
            <div class='col-1 wrecclesham-logo d-none d-md-block'>
            </div>"
        tweet += "<div class='col-12 col-md-11'>
          #{value.text}
        </div>"
        tweet += '</div></li>'

        twitterList += tweet
      )
      twitterList += '</ul>'
      twitterContainer.html(twitterList)
    )
