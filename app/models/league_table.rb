# frozen_string_literal: true

class LeagueTable < ApplicationRecord
  has_many :seasons, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :fixtures, as: :competition

  validates :name, :year, :url, :fixture_url, :results_url, presence: true

  before_destroy :check_league_not_active
  def check_league_not_active
    if active_first_team_table || active_reserve_team_table
      errors.add(:league_table, 'can not be deleted when an active league table')
      throw(:abort)
    end
  end

  validate :can_only_be_active_for_one_team
  def can_only_be_active_for_one_team
    if active_first_team_table && active_reserve_team_table
      errors.add(:league_table, 'can only be active for first team or reserve team')
    end
  end

  def self.active_first_team_table
    where(active_first_team_table: true).first
  end

  def self.active_reserve_team_table
    where(active_reserve_team_table: true).first
  end

  def scheduled_fixtures
    fixtures.fixtures
  end

  def results
    fixtures.results
  end

  def set_active_league(params, new_table_id)
    return unless params[:active_first_team_table] || params[:active_reserve_team_table]

    table_to_update = params.keys.detect { |key| key.match(/active_[a-z]+_team_table/) }
    old_table = LeagueTable.where(table_to_update => true).where.not(id: new_table_id).first
    old_table&.update(table_to_update => false)
  end
end
