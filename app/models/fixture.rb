require 'open-uri'
require 'nokogiri'

class Fixture < ApplicationRecord
  belongs_to :competition, polymorphic: true
  belongs_to :home, class_name: 'Team', foreign_key: "home_id"
  belongs_to :away, class_name: 'Team', foreign_key: "away_id"

  scope :fixtures, -> { where("date >= ?", Time.now.utc.to_date).or(Fixture.where(date: nil)) }
  scope :results, -> { where("date < ?", Time.now.utc.to_date) }
  scope :last_game, ->(team) { where(home: team).where.not(home_score: nil).or(Fixture.where(away: team).where.not(away_score: nil)).order(date: :desc).first }
  scope :team_results, ->(team) { where(home: team).where.not(home_score: nil).or(Fixture.where(away: team).where.not(away_score: nil)).order(date: :desc) }
  scope :team_fixtures, ->(team) { where(home: team).where(home_score: nil).or(Fixture.where(away: team).where(away_score: nil)).order(date: :asc) }

  class << self
    def create_fixtures(team)
      team.competitions.each do |competition|
        fixtures = FixtureScrapper.get_fixtures_data(competition.fixture_url)
        fixtures.each do |fixture|
          next if postponed?(fixture)
          date = DateTime.strptime(fixture[1][0..7], '%d/%m/%y').to_date rescue nil
          home = Team.find_or_create_by(name: fixture[2])
          away = Team.find_or_create_by(name: fixture[3])
          next if Fixture.exists?(date: date, home: home, away: away, competition: competition)
          next unless competition
          Fixture.create!(
            date: date,
            home_id: home.id,
            away_id: away.id,
            competition: competition
          )
        end
      end
    end

    def update_fixtures(team)
      team.competitions.each do |competition|
        fixtures = FixtureScrapper.get_fixtures_data(competition.results_url)
        fixtures.each do |fixture|
          home = Team.find_or_create_by(name: fixture[2])
          away = Team.find_or_create_by(name: fixture[4])
          current_fixture = Fixture.find_by(home: home, away: away, competition: competition)
          home_score, away_score = fixture[3].split('-')
          if current_fixture
            current_fixture.update!(home_score: home_score, away_score: away_score)
          else
            date = DateTime.strptime(fixture[1][0..7], '%d/%m/%y').to_date rescue nil
            current_fixture = Fixture.find_or_create_by(home: home, away: away, competition: competition)
            current_fixture.update!(date: date, home_score: home_score, away_score: away_score)
          end
        end
      end
    end

    def next_game(team)
      where(home: team, home_score: nil).or(where(away: team, away_score: nil)).order(date: :asc).first
    end

    private

    def postponed?(fixture)
      fixture.any?{ |s| s.casecmp("Postponed") == 0 }
    end
  end
end
