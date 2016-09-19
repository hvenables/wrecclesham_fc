module FixturesHelper
  def create_fixtures(league_table_id)
    league_table = LeagueTable.find(league_table_id)
    fixtures = FixtureScrapper.get_fixtures_data(league_table.fixture_url)
    fixtures.each do |fixture|
      next if fixture[0] != 'Div' + league_table.name[-1]
      Fixture.create(
        date: Date.parse(fixture[1][0..7]),
        home_id: Team.find_by(name: fixture[2].underscore.split('_').collect{|c| c.capitalize}.join(' ')).id,
        away_id: Team.find_by(name: fixture[3].underscore.split('_').collect{|c| c.capitalize}.join(' ')).id,
        league_table_id: league_table.id
      )
    end
  end
end
