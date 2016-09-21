# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.

$(document).on "turbolinks:load", ->
  simplemde = new SimpleMDE({ element: $(".news-content")[0] })

  if $(".news-summary").length != 0
    simplemde1 = new SimpleMDE({ element: $(".news-summary")[0] })
