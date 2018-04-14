# frozen_string_literal: true

class SeasonsController < ApplicationController
  include SeasonsHelper

  before_action :load_league, only: %i[create update]

  def index; end

  def show; end

  def create
    if Season.create_teams(LeagueTableScrapper.get_team_data(@league_table.url), @league_table)
      flash[:notice] = 'League Tables seasons created'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to league_table_path(@league_table)
  end

  def update
    if Season.update_teams(LeagueTableScrapper.get_team_data(@league_table.url), @league_table)
      flash[:notice] = 'League Table has been updated'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to league_table_path(@league_table)
  end

  private

  def load_league
    @league_table = Competition::LeagueTable.find(params[:league_table_id])
  end
end
