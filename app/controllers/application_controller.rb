# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :load_league, :load_teams, :load_cups

  private

  def load_teams
    @first_team = Team.first_team
    @reserve_team = Team.reserve_team
  end

  def load_league
    @first_team_table = LeagueTable.active_first_team_table
    @reserve_team_table = LeagueTable.active_reserve_team_table
  end

  def load_cups
    @cups = Cup.active
  end
end
