class Team < ApplicationRecord
  has_many :seasons
  has_many :fixtures, as: :home
  has_many :fixtures, as: :away

  scope :first_team, -> { find_by(name: "Wrecclesham") }
  scope :reserve_team, -> { find_by(name: "Wrecclesham Reserves") }

end
