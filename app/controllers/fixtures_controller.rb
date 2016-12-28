class FixturesController < ApplicationController

  def index
    binding.pry
    if params[:league_table_id]
      @league_table = LeagueTable.find(params[:league_table_id])
      @fixtures = Fixture.fixtures.where(competition: @league_table).order(date: :asc)
      @results = Fixture.results.where(competition: @league_table).order(date: :desc)
    elsif params[:team_id]
      @team = Team.find(params[:team_id])
      @fixtures = Fixture.fixtures.team_results(@team)
      @results = Fixture.results.team_results(@team)
    end
  end

  def create
    if params[:fixtures]
      Fixture.create_fixtures(params[:league_table_id])
    else
      Fixture.update_fixtures(params[:league_table_id])
    end
    redirect_to league_table_fixtures_path(params[:league_table_id])
  end

  private

  def fixture_params
    params.permit(:league_table_id)
  end
end
