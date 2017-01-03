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

  def seven_positions_around_team
    positions = []
    all_teams = self.league_table.teams
    while positions.length < 7
      calc_up_and_down(self.current_season.position, positions, all_teams.length) if positions.empty?
      if positions.last < all_teams.length
        positions << positions.last + 1
      else
        positions << positions.first - 1
        positions.sort!
      end
    end
    Season.where(league_table: self.league_table).select{|season| positions.include? season.position}.sort{|a,b| a.position <=> b.position}
  end

  def competitions
    [self.league_table] + self.cups
  end

  private

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
