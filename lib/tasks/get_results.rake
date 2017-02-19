desc "Get Results"
task get_results: :environment do
  Team.first_team.update_fixtures
  Team.reserve_team.update_fixtures
end
