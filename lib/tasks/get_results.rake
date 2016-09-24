desc "Get Results"
task get_results: :environment do
  first_team_table = LeagueTable.find_by(active_first_team_table: true)
  reserve_team_table = LeagueTable.find_by(active_reserve_team_table: true)
  Fixture.update_fixtures(first_team_table.id)
  Fixture.update_fixtures(reserve_team_table.id)
end
