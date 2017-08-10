# frozen_string_literal: true

class Competition < ApplicationRecord
  has_many :fixtures
  has_many :team_competitions
  has_many :teams, through: :team_competitions

  scope :active, (-> { where(active: true) })

  before_destroy :cannot_delete_active_competition
  def cannot_delete_active_competition
    return unless active?

    errors.add(:competition, 'can not be deleted when an active')
    throw(:abort)
  end

  def scheduled_fixtures
    fixtures.fixtures
  end

  def results
    fixtures.results
  end
end
