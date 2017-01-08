require 'open-uri'
require 'nokogiri'

class Fixture < ApplicationRecord
  belongs_to :league_table
  belongs_to :home, class_name: 'Team', foreign_key: "home_id"
  belongs_to :away, class_name: 'Team', foreign_key: "away_id"

  scope :fixtures, -> { where("date >= ?", Time.now.utc.to_date) }
  scope :results, -> { where("date < ?", Time.now.utc.to_date) }
  scope :last_game, ->(team) { where(home: team).where.not(home_score: nil).or(Fixture.where(away: team).where.not(away_score: nil)).order(date: :desc).first }
  scope :team_results, ->(team) { where(home: team).where.not(home_score: nil).or(Fixture.where(away: team).where.not(away_score: nil)).order(date: :desc) }

  class << self
    def create_fixtures(league_table_id)
      league_table = LeagueTable.find(league_table_id)
      fixtures = FixtureScrapper.new(league_table.fixture_url).fixtures
      fixtures.each do |fixture|
        next if not_league_game?(fixture) || postponed?(fixture)
        date = DateTime.strptime(fixture[1][0..7], '%d/%m/%y').to_date
        home = Team.find_by(name: fixture[2])
        away = Team.find_by(name: fixture[3])
        next if Fixture.exists?(date: date, home: home, away: away, league_table: league_table)
        Fixture.create!(
          date: date,
          home_id: home.id,
          away_id: away.id,
          league_table_id: league_table.id
        )
      end
    end

    def update_fixtures(league_table_id)
      league_table = LeagueTable.find(league_table_id)
      fixtures = FixtureScrapper.new(league_table.results_url).fixtures
      fixtures.each do |fixture|
        next if not_league_game?(fixture)
        date = DateTime.strptime(fixture[1][0..7], '%d/%m/%y').to_date
        home = Team.find_by(name: fixture[2])
        away = Team.find_by(name: fixture[4])
        current_fixture = Fixture.find_by(date: date, home: home, away: away, league_table: league_table)
        home_score, away_score = fixture[3].split('-').map(&:strip)
        if current_fixture
          current_fixture.update!(home_score: home_score, away_score: away_score)
        else
          current_fixture = Fixture.find_or_create_by(date: date, home: home, away: away, league_table: league_table)
          current_fixture.update!(home: home, away: away, home_score: home_score, away_score: away_score)
        end
      end
    end

    def next_game(team)
      where(home: team, home_score: nil).or(where(away: team, away_score: nil)).order(date: :asc).first
    end

    private

    def not_league_game?(fixture)
      !fixture[0].match(/Div[0-9]/)
    end

    def postponed?(fixture)
      fixture.any?{ |s| s.casecmp("Postponed") == 0 }
    end
  end
end
