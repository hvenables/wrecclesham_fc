# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :team_competitions
  has_many :competitions, through: :team_competitions
  has_many :league_tables, through: :team_competitions, source: :competition, class_name: 'Competition::LeagueTable'
  has_many :cups, through: :team_competitions, source: :competition, class_name: 'Competition::Cup'
  has_many :seasons
  has_many :home_fixtures, class_name: 'Fixture', foreign_key: 'home_id'
  has_many :away_fixtures, class_name: 'Fixture', foreign_key: 'away_id'

  class << self
    def first_team
      find_by name: 'Wrecclesham'
    end

    def reserve_team
      find_by name: 'Wrecclesham Reserves'
    end
  end

  def current_league_table
    league_tables.find_by(active: true)
  end

  def current_season
    Season.find_by(team: self, league_table: current_league_table)
  end

  def scheduled_fixtures
    Fixture.fixtures.where(home: self).or(Fixture.fixtures.where(away: self))
  end

  def results
    Fixture.results.where(home: self).or(Fixture.results.where(away: self))
  end

  def next_game
    Fixture
      .where(home: self, home_score: nil)
      .or(
        Fixture
          .where(away: self, away_score: nil)
      )
      .order(date: :asc).first
  end

  def last_game
    Fixture
      .where(home: self)
      .where.not(home_score: nil)
      .or(
        Fixture
          .where(away: self)
          .where.not(away_score: nil)
      )
      .order(date: :desc).first
  end

  def create_fixtures
    competitions.active.each do |competition|
      next unless competition.active?
      fixtures = FixtureScrapper.new(competition.fixture_url).fixtures if competition.fixture_url?
      fixtures&.each do |fixture|
        next if postponed?(fixture)
        date = begin
                DateTime.strptime(fixture[0][0..7], '%d/%m/%y').to_date
              rescue
                nil
              end
        home = Team.find_or_create_by(name: fixture[1])
        away = Team.find_or_create_by(name: fixture[2])
        next if Fixture.exists?(date: date, home: home, away: away, competition: competition)
        next unless competition
        Fixture.create(
          date: date,
          home_id: home.id,
          away_id: away.id,
          competition: competition
        )
      end
    end
  rescue => e
    Rollbar.warning(e, 'Something went wrong when creating fixtures')
    false
  end

  def update_fixtures
    competitions.active.each do |competition|
      fixtures = FixtureScrapper.new(competition.result_url).fixtures if competition.result_url?
      fixtures&.each do |fixture|
        home = Team.find_or_create_by(name: fixture[1])
        away = Team.find_or_create_by(name: fixture[3])
        current_fixture = Fixture.find_by(home: home, away: away, competition: competition)
        home_score, away_score = fixture[2].split(' - ')
        if current_fixture
          current_fixture.update(home_score: home_score, away_score: away_score)
        else
          date = begin
                  DateTime.strptime(fixture[0][0..7], '%d/%m/%y').to_date
                rescue
                  nil
                end
          current_fixture = Fixture.find_or_create_by(home: home, away: away, competition: competition)
          current_fixture.update!(date: date, home_score: home_score, away_score: away_score)
        end
      end
    end
  rescue => e
    Rollbar.warning(e, 'Something went wrong when creating fixtures')
    false
  end

  private

  def postponed?(fixture)
    fixture.any? { |s| s.casecmp('Postponed').zero? }
  end
end
