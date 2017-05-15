# frozen_string_literal: true

class Team < ApplicationRecord
  belongs_to :league_table
  has_many :team_cups
  has_many :cups, through: :team_cups
  has_many :seasons
  has_many :home_fixtures, class_name: Fixture, foreign_key: 'home_id'
  has_many :away_fixtures, class_name: Fixture, foreign_key: 'away_id'

  class << self
    def first_team
      find_by name: 'Wrecclesham'
    end

    def reserve_team
      find_by name: 'Wrecclesham Reserves'
    end
  end

  def current_season
    Season.find_by(team: self, league_table: league_table)
  end

  def competitions
    [league_table] + cups
  end

  def scheduled_fixtures
    Fixture.fixtures.where(home: self).or(Fixture.fixtures.where(away: self))
  end

  def results
    Fixture.results.where(home: self).or(Fixture.results.where(away: self))
  end

  def next_game
    Fixture.where(
      home: self,
      home_score: nil
    ).or(
      Fixture.where(
        away: self,
        away_score: nil
      )
    ).order(date: :asc).first
  end

  def last_game
    Fixture.where(
      home: self
    ).where.not(
      home_score: nil
    ).or(
      Fixture.where(
        away: self
      ).where.not(
        away_score: nil
      )
    ).order(date: :desc).first
  end

  def create_fixtures
    Team.transaction do
      competitions.each do |competition|
        fixtures = FixtureScrapper.new(competition.fixture_url).fixtures
        fixtures.each do |fixture|
          next if postponed?(fixture)
          date = begin
                  DateTime.strptime(fixture[1][0..7], '%d/%m/%y').to_date
                rescue
                  nil
                end
          home = Team.find_or_create_by(name: fixture[2])
          away = Team.find_or_create_by(name: fixture[3])
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
    end
  rescue => e
    Rollbar.warning(e, 'Something went wrong when creating fixtures')
    false
  end

  def update_fixtures
    Team.transaction do
      competitions.each do |competition|
        fixtures = FixtureScrapper.new(competition.results_url).fixtures
        fixtures.each do |fixture|
          home = Team.find_or_create_by(name: fixture[2])
          away = Team.find_or_create_by(name: fixture[4])
          current_fixture = Fixture.find_by(home: home, away: away, competition: competition)
          home_score, away_score = fixture[3].split(' - ')
          if current_fixture
            current_fixture.update(home_score: home_score, away_score: away_score)
          else
            date = begin
                    DateTime.strptime(fixture[1][0..7], '%d/%m/%y').to_date
                  rescue
                    nil
                  end
            current_fixture = Fixture.find_or_create_by(home: home, away: away, competition: competition)
            current_fixture.update!(date: date, home_score: home_score, away_score: away_score)
          end
        end
      end
    end
  rescue => e
    Rollbar.warning(e, 'Something went wrong when creating fixtures')
    false
  end

  def seven_teams_around_team
    Season.where(league_table: league_table, position: seven_positions_around_team).order(position: :asc)
  end

  private

  def postponed?(fixture)
    fixture.any? { |s| s.casecmp('Postponed') == 0 }
  end

  def seven_positions_around_team
    current_position = current_season.position
    number_of_teams  = current_season.league_table.number_of_teams

    start = current_position - 3 < 1 ? 1 : current_position - 3
    finish = current_position + 3 > number_of_teams ? number_of_teams : current_position + 3
    positions = (start..finish).to_a

    while positions.length < 7
      if positions.last < number_of_teams
        positions.push(positions.last + 1)
      else
        positions.unshift(positions.first - 1)
      end
    end

    positions
  end
end
