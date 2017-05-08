# frozen_string_literal: true

desc 'Update league table'
task update_league_tables: :environment do
  first_team_table = LeagueTable.find_by(active_first_team_table: true)
  reserve_team_table = LeagueTable.find_by(active_reserve_team_table: true)
  Season.update_teams(LeagueTableScrapper.get_team_data(first_team_table.url, first_team_table.number_of_teams), first_team_table.id)
  Season.update_teams(LeagueTableScrapper.get_team_data(reserve_team_table.url, reserve_team_table.number_of_teams), reserve_team_table.id)
end
