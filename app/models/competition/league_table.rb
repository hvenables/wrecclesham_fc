# frozen_string_literal: true

class Competition
  class LeagueTable < Competition
    has_many :seasons, dependent: :destroy

    validates :url, :fixture_url, presence: true

    before_save :only_one_active_table
    def only_one_active_table
      return unless active_changed?

      case self
      when ->(competition) { competition.first_team_competition? }
        Competition::LeagueTable
          .first_team_competitions.where.not(id: self)
          .update_all(active: false)
      when ->(competition) { competition.reserve_team_competition? }
        Competition::LeagueTable
          .reserve_team_competitions.where.not(id: self)
          .update_all(active: false)
      end
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

    def first_team_tables
      joins(:teams).find_by(active: true, teams: { name: 'Wrecclesham' })
    end

    def reserve_team_tables
      joins(:teams).find_by(active: true, teams: { name: 'Wrecclesham Reserves' })
    end
  end
end
