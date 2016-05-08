class TeamsController < ApplicationController
  include TeamsHelper

  before_action :load_league, only: :create

  def index
    @teams = Team.all.order(team: :asc)
  end

  def show

  end

  def create
    if @league_table.teams.empty?
      create_teams(LeagueTableScrapper.get_team_data(@league_table.url, @league_table.number_of_teams), params[:league_table_id])
    else
      update_teams(LeagueTableScrapper.get_team_data(@league_table.url, @league_table.number_of_teams), params[:league_table_id])
    end
    redirect_to league_table_path(@league_table)
  end

  private

  def load_league
    @league_table = LeagueTable.find(params[:league_table_id])
  end
end
