desc "Get Fixtures"
task get_fixtures: :environment do
  first_team_table = LeagueTable.find_by(active_first_team_table: true)
  reserve_team_table = LeagueTable.find_by(active_reserve_team_table: true)
  Fixture.create_fixtures(first_team_table.id)
  Fixture.create_fixtures(reserve_team_table.id)
end
