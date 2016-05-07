class Team < ApplicationRecord
  # has_many :players
  belongs_to :league_table

  def self.ordered_on_points
    order(points: :desc, goal_difference: :desc)
  end

end
