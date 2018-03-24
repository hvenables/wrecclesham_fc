# frozen_string_literal: true

class Competition
  class LeagueTable < Competition
    has_many :seasons, dependent: :destroy

    validates :url, :fixture_url, presence: true

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
