class TeamsController < ApplicationController
  include TeamsHelper

  before_action :load_league, only: :create

  def index
    @teams = Team.all.order(team: :asc)
  end

  def show

  end

  def create
    if @league_table.teams.nil?
      create_teams(Team.get_table_data(@league_table.url), params[:league_table_id])
    else
      update_teams(Team.get_table_data(@league_table.url), params[:league_table_id])
    end
    redirect_to league_table_path(@league_table)
  end

  private

  def load_league
    @league_table = LeagueTable.find(params[:league_table_id])
  end
end
