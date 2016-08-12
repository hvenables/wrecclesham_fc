module FixturesHelper
  def create_fixtures(league_table_id)
    url = LeagueTable.find(league_table_id).fixture_url
    fixtures = FixtureScrapper.get_fixtures(url)
    team_fixtures = fixtures[0]
    dates_fixtures = fixtures[1]
    team_fixtures.each_with_index do |monthly_fixtures, monthly_index|
      monthly_fixtures.each_with_index do |weekly_fixtures, weekly_index|
        weekly_fixtures.each do |fixture|
          Fixture.create(
            date: dates_fixtures[monthly_index][weekly_index].to_s,
            home: Team.find_by(team: fixture[2]).id,
            away: Team.find_by(team: fixture[4]).id,
            home_score: fixture[0],
            away_score: fixture[1],
            league_table_id: league_table_id
          )
        end
      end
    end
  end
end
