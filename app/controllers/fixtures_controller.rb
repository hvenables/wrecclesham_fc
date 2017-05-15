# frozen_string_literal: true

class FixturesController < ApplicationController
  before_action :load_team, only: %i[create update]
  before_action :load_subject, only: :show

  def show
    @fixtures = @subject.scheduled_fixtures
    @results = @subject.results
  end

  def create
    if @team.create_fixtures
      flash[:success] = 'Fixtures have been created'
    else
      flash[:error] = 'Something went wrong creating the fixtures, please try again later'
    end
    redirect_to team_fixtures_path(params[:team_id])
  end

  def update
    if @team.update_fixtures
      flash[:success] = 'Fixtures have been updated'
    else
      flash[:error] = 'Something went wrong updating the fixtures, please try again later'
    end
    redirect_to team_fixtures_path(params[:team_id])
  end

  private

  def load_team
    @team = Team.find(params[:team_id]) if params[:team_id]
  end

  def load_subject
    @subject = Team.find_by(id: params[:team_id])
    @subject ||= LeagueTable.find_by(id: params[:league_table_id])
    @subject ||= Cup.find_by(id: params[:cup_id])
  end

  def fixture_params
    params.permit(:league_table_id)
  end
end
