# frozen_string_literal: true

class Season < ApplicationRecord
  belongs_to :team
  belongs_to :league_table, class_name: 'Competition::LeagueTable'

  def self.ordered_on_points
    order(position: :asc)
  end

  def self.create_teams(table_data, current_league)
    table_data.each do |team_name, season|
      current_team = Team.find_by(name: team_name)
      season = Season.create!(season_attributes(season, current_team, current_league))
      season.team.league_tables << current_league unless season.team.league_tables.include? current_league
    end
  end

  def self.update_teams(table_data, current_league)
    table_data.each do |team_name, season|
      current_team = Team.find_by(name: team_name)
      if current_team
        current_season = Season.find_by(team: current_team, league_table: current_league)
        current_season.update!(season_attributes(season, current_team, current_league))
      else
        Rollbar.warning('Team has been added to the league!, wtf!')
        create_teams([season], current_league)
      end
    end
  rescue => e
    Rollbar.warning('Could not update the table', e)
    nil
  end

  def self.season_attributes(season_data, team, league_table)
    {
      position: season_data[0],
      team: team,
      games: season_data[1],
      won: season_data[12],
      drawn: season_data[13],
      lost: season_data[14],
      goals_for: season_data[15],
      goals_against: season_data[16],
      goals_difference: season_data[15].to_i - season_data[16].to_i,
      points: season_data[18],
      league_table: league_table,
      home_wins: season_data[2],
      home_drawn: season_data[3],
      home_lost: season_data[4],
      home_goals_for: season_data[5],
      home_goals_against: season_data[6],
      away_wins: season_data[7],
      away_drawn: season_data[8],
      away_lost: season_data[9],
      away_goals_for: season_data[10],
      away_goals_against: season_data[11]
    }
  end
end
