# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

class Fixture < ApplicationRecord
  belongs_to :competition
  belongs_to :home, class_name: 'Team', foreign_key: 'home_id'
  belongs_to :away, class_name: 'Team', foreign_key: 'away_id'

  scope :fixtures, -> { where('date >= ?', Time.now.utc.to_date).order(date: :asc) }
  scope :results, -> { where('date < ?', Time.now.utc.to_date).order(date: :desc) }
  # should probably be on competition
  scope :league_fixtures, ->(league_table) { where(competition: league_table).order(date: :asc) }
  scope :league_results, ->(league_table) { where(competition: league_table).order(date: :desc) }
  scope :active_competition, -> { joins(:competition).where(competitions: { active: true }) }

  def self.delete_cancelled
    where(date: (Time.now.utc - 1.month)...Time.now.utc, home_score: nil, away_score: nil).destroy_all
  end
end
