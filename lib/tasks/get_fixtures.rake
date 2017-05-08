# frozen_string_literal: true

desc 'Get Fixtures'
task get_fixtures: :environment do
  Team.first_team.create_fixtures
  Team.reserve_team.create_fixtures
end
