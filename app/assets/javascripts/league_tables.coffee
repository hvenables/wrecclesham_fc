guarded_ready ->
  $('.active_first_team_table').click ->
    $this = $(this)
    data = { competition_league_table: { active: true }, table: 'first_team' }
    updateActiveLeagueTable($this, data)

  $('.active_reserve_team_table').click ->
    $this = $(this)
    data = { competition_league_table: { active: true }, table: 'reserve_team' }
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
        updateCheckedLeague(table_name, response.table, element)
      else
        flashMessage('League Table updated successfully', 'success')
    error: (jqXHR, textStatus, errorThrown) ->
      flashMessage('League Table could not update active league table, please try again', 'danger')

updateCheckedLeague = (table_name, table, element) ->
  if table
    $("##{table_name}-#{table}").prop('checked', true)
  else
    element.prop('checked', false)
