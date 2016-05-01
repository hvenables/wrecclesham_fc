class LeagueTable < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :fixtures
end
