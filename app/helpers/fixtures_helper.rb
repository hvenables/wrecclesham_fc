# frozen_string_literal: true

module FixturesHelper
  def competition_path(competition)
    case competition
    when Competition::LeagueTable
      league_table_path(competition)
    when Competition::Cup
      cup_fixtures_path(competition)
    end
  end
end
