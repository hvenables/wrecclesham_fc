class LeagueTable < ApplicationRecord
  has_many :seasons, dependent: :destroy
  # has_many :fixtures

  def self.active_first_team_table
    where(active_first_team_table: true).first
  end

  def self.active_reserve_team_table
    where(active_reserve_team_table: true).first
  end

end
