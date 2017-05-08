# frozen_string_literal: true

class FixturesController < ApplicationController
  before_action :load_team, only: %i[create update]
  before_action :load_subject, only: :show

  def show
    @fixtures = @subject.scheduled_fixtures
    @results = @subject.results
  end

  def create
    # Good to introduce if statement here
    @team.create_fixtures
    redirect_to team_fixtures_path(params[:team_id])
  end

  def update
    # Good to introduce if statement here
    @team.update_fixtures
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
