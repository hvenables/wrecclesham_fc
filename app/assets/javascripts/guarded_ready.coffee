(exports ? this).guarded_ready = (callback) ->
  $(document).on 'turbolinks:load', ->
    try
      callback()
    catch e
      Rollbar.error(e) if Rollbar?
      console.error(e)
