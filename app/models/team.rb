class Team < ApplicationRecord
  has_many :seasons
  has_many :fixtures, as: :home
  has_many :fixtures, as: :away

end
