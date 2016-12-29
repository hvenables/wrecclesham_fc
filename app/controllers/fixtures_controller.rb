class FixturesController < ApplicationController

  def index
    if params[:league_table_id]
      @league_table = LeagueTable.find(params[:league_table_id])
      @fixtures = Fixture.fixtures.where(competition: @league_table).order(date: :asc)
      @results = Fixture.results.where(competition: @league_table).order(date: :desc)
    elsif params[:team_id]
      @team = Team.find(params[:team_id])
      @fixtures = Fixture.fixtures.team_fixtures(@team)
      @results = Fixture.results.team_results(@team)
    end
  end

  def create
    team = Team.find(params[:team_id])
    league_table = LeagueTable.find_by(id: params[:league_table_id]) || LeagueTable.find_by(id: team.league_table_id)
    if params[:fixtures]
      Fixture.create_fixtures(league_table)
    else
      Fixture.update_fixtures(league_table)
    end
    redirect_to team_fixtures_path(params[:team_id])
  end

  private

  def fixture_params
    params.permit(:league_table_id)
  end
end
