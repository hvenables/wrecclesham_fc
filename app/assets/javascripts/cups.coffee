# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

guarded_ready ->
  $('.toggle-cup-activity').click ->
    data = $(this).data()
    cup_data = { competition_cup: { active: data.active }, id: data.id }
    toggleCupActivity(cup_data)

toggleCupActivity = (data) ->
  $.ajax "/cups/#{data.id}",
    type: "PATCH",
    data: data,
    dataType: 'json',
    success: (response) ->
      if response.errors
        flashMessage(response.errors, 'danger')
      else
        flashMessage('Cup updated successfully', 'success')
    error: (jqXHR, textStatus, errorThrown) ->
      flashMessage('Could not update active league table, please try again', 'danger')
