# frozen_string_literal: true

class Competition
  class LeagueTable < Competition
    has_many :seasons, dependent: :destroy
    validates :name, :year, :url, :fixture_url, :result_url, presence: true

    # validate :can_only_be_active_for_one_team
    def can_only_be_active_for_one_team
      return if active?
      return unless active_first_team_table? || active_reserve_team_table?

      errors.add(:league_table, 'can only be active for first team or reserve team')
    end

    def self.active_first_team_table
      joins(:teams).find_by(active: true, teams: { name: 'Wrecclesham' })
    end

    def self.active_reserve_team_table
      joins(:teams).find_by(active: true, teams: { name: 'Wrecclesham Reserves' })
    end

    def active_first_team_table?
      active == true && teams.include?(Team.first_team)
    end

    def active_reserve_team_table?
      active == true && teams.include?(Team.reserve_team)
    end
  end
end
