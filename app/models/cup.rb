class Cup < ApplicationRecord
  has_many :team_cups
  has_many :teams, through: :team_cups
end
