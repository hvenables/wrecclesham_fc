$(document).on 'turbolinks:load', ->
  $('.active_first_team_table').click ->
    $this = $(this)
    data = { "league_table": { "#{$this.attr("class")}": true }, table: 'first_team' }
    updateActiveLeagueTable($this, data)

  $('.active_reserve_team_table').click ->
    $this = $(this)
    data = { "league_table": { "#{$this.attr("class")}": true }, table: 'reserve_team' }
    updateActiveLeagueTable($this, data)

updateActiveLeagueTable = (element, data) ->
  table_name = element.attr('id').split('-')[0]
  id = element.attr('id').split('-')[1]

  $.ajax "/league_tables/#{id}",
    type: "PATCH",
    data: data,
    dataType: "json",
    success: (response) ->
      if response.errors
        flashMessage(response.errors.league_table, 'danger')
        $("##{table_name}-#{response.table}").prop('checked', true)
      else
        flashMessage('updated successfully', 'success')
    error: (jqXHR, textStatus, errorThrown) ->
      flashMessage('Could not update active league table, please try again', 'danger')

flashMessage = (message, level) ->
  $('.flash').append(
      "<div class='container'>
        <div class='alert alert-#{level} flash-title'>
          <button class='close' data-dismiss='alert'>x</button>
          League table #{message}
        </div>
      </div>"
    )
