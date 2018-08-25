# frozen_string_literal: true

class Competition < ApplicationRecord
  has_many :fixtures
  has_many :team_competitions
  has_many :teams, through: :team_competitions

  validates :name, :year, :result_url, presence: true

  scope :active, (-> { where(active: true) })
  scope :first_team_competitions, lambda {
    left_joins(:teams).where(teams: { name: 'Wrecclesham' })
  }

  scope :reserve_team_competitions, lambda {
    left_joins(:teams).where(teams: { name: 'Wrecclesham Reserves' })
  }

  before_destroy :cannot_delete_active_competition
  def cannot_delete_active_competition
    return unless active?

    errors.add(:competition, 'can not be deleted when an active')
    throw(:abort)
  end

  def first_team_competition?
    teams.where(id: Team.find_by(name: 'Wrecclesham')).any?
  end

  def reserve_team_competition?
    teams.where(id: Team.find_by(name: 'Wrecclesham Reserves')).any?
  end

  def scheduled_fixtures
    fixtures.fixtures
  end

  def results
    fixtures.results
  end
end
