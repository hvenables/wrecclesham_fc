(exports ? this).flashMessage = (message, level) ->
  $('.flash').html(
    "<div class='container'>
      <div class='alert alert-#{level} flash-title'>
        <button class='close' data-dismiss='alert'>x</button>
        #{message}
      </div>
    </div>"
  )

