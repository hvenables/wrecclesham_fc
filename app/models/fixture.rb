require 'open-uri'
require 'nokogiri'

class Fixture < ApplicationRecord
  belongs_to :league_table
  belongs_to :home, class_name: 'Team', foreign_key: "home_id"
  belongs_to :away, class_name: 'Team', foreign_key: "away_id"

  def self.create_fixtures(league_table_id)
    league_table = LeagueTable.find(league_table_id)
    fixtures = FixtureScrapper.get_fixtures_data(league_table.fixture_url)
    fixtures.each do |fixture|
      next if fixture[0] != 'Div' + league_table.name[-1]
      Fixture.create(
        date: DateTime.strptime(fixture[1][0..7], '%d/%m/%y').to_date,
        home_id: Team.find_by(name: fixture[2].underscore.split('_').collect{|c| c.capitalize}.join(' ')).id,
        away_id: Team.find_by(name: fixture[3].underscore.split('_').collect{|c| c.capitalize}.join(' ')).id,
        league_table_id: league_table.id
      )
    end
  end

  def self.update_fixtures(league_table_id)
    league_table = LeagueTable.find(league_table_id)
    fixtures = FixtureScrapper.get_results_data(league_table.results_url)
    fixtures.each do |fixture|
      next if fixture[0] != 'Div' + league_table.name[-1]
      Fixture.create(
        date: DateTime.strptime(fixture[1][0..7], '%d/%m/%y').to_date,
        home_id: Team.find_by(name: fixture[2].underscore.split('_').collect{|c| c.capitalize}.join(' ')).id,
        away_id: Team.find_by(name: fixture[4].underscore.split('_').collect{|c| c.capitalize}.join(' ')).id,
        home_score: fixture[3].split('-')[0],
        away_score: fixture[3].split('-')[1],
        league_table_id: league_table.id
      )
    end
  end
end
