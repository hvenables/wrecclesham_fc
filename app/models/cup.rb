# frozen_string_literal: true

class Cup < ApplicationRecord
  has_many :team_cups
  has_many :teams, through: :team_cups
  has_many :fixtures, as: :competition

  scope :active, -> { where(active: true) }

  def scheduled_fixtures
    fixtures.fixtures
  end

  def results
    fixtures.results
  end
end
