class Team < ApplicationRecord
  belongs_to :league_table
  has_many :team_cups
  has_many :cups, through: :team_cups
  has_many :seasons
  has_many :home_fixtures, class_name: Fixture, foreign_key: 'home_id'
  has_many :away_fixtures, class_name: Fixture, foreign_key: 'away_id'

  scope :first_team, -> { find_by(name: "Wrecclesham") }
  scope :reserve_team, -> { find_by(name: "Wrecclesham Reserves") }

  serialize :cups

  def current_season
    Season.find_by(team: self, league_table: self.league_table)
  end

  def competitions
    [self.league_table] + self.cups
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
    competitions.each do |competition|
      fixtures = FixtureScrapper.new(competition.fixture_url).fixtures
      fixtures.each do |fixture|
        next if postponed?(fixture)
        date = DateTime.strptime(fixture[1][0..7], '%d/%m/%y').to_date rescue nil
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

  def update_fixtures
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
          date = DateTime.strptime(fixture[1][0..7], '%d/%m/%y').to_date rescue nil
          current_fixture = Fixture.find_or_create_by(home: home, away: away, competition: competition)
          current_fixture.update!(date: date, home_score: home_score, away_score: away_score)
        end
      end
    end
  end

  def seven_positions_around_team
    positions = []
    all_teams = self.league_table.teams
    calc_up_and_down(self.current_season.position, positions, all_teams.length) if positions.empty?
    while positions.length < 7
      if positions.last < all_teams.length
        positions << positions.last + 1
      else
        positions << positions.first - 1
        positions.sort!
      end
    end
    Season.where(league_table: self.league_table).select{|season| positions.include? season.position}.sort{|a,b| a.position <=> b.position}
  end

  private

  def postponed?(fixture)
    fixture.any?{ |s| s.casecmp("Postponed") == 0 }
  end

  def calc_up_and_down(index, numbers, league_size)
    counter = index
    3.times do
      counter -= 1
      numbers << counter if counter > 0
    end
    counter = index
    3.times do
      counter += 1
      numbers << counter if counter < league_size
    end
    numbers << index
    numbers.sort!
  end
end
