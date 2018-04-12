# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.

guarded_ready ->
  if $(".news-content").length > 0
    simplemde = new SimpleMDE({ element: $(".news-content")[0] })
