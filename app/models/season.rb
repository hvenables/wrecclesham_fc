class Season < ApplicationRecord
  belongs_to :team
  belongs_to :league_table

  def self.ordered_on_points
    order(position: :asc)
  end

end
