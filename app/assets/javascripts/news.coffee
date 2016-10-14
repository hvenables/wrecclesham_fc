# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.

guarded_ready ->

  $('.carousel').not('.slick-initialized').slick({
    infinite: true,
    speed: 300,
    slidesToShow: 4,
    slidesToScroll: 1,
    responsive: [
      {
        breakpoint: 1024,
        settings: {
          slidesToShow: 3,
          slidesToScroll: 1,
          infinite: true,
          dots: true
        }
      },
      {
        breakpoint: 600,
        settings: {
          slidesToShow: 2,
          slidesToScroll: 1
        }
      },
      {
        breakpoint: 480,
        settings: {
          slidesToShow: 1,
          slidesToScroll: 1
        }
      }
    ]
  })

  simplemde = new SimpleMDE({ element: $(".news-content")[0] })

  if $(".news-summary").length != 0
    simplemde1 = new SimpleMDE({ element: $(".news-summary")[0] })

$(document). on "turbolinks:before-cache", ->
  $('.carousel').slick('unslick')
