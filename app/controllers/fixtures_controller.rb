class FixturesController < ApplicationController

  def index
    @league_table = LeagueTable.find(params[:league_table_id])
    @fixtures = Fixture.fixtures.where(competition: @league_table).order(date: :asc)
    @results = Fixture.results.where(competition: @league_table).order(date: :desc)
  end

  def create
    if params[:fixtures]
      Fixture.create_fixtures(params[:league_table_id])
    else
      Fixture.update_fixtures(params[:league_table_id])
    end
    redirect_to league_table_fixtures_path(params[:league_table_id])
  end

  def show
    @home_fixtures = Fixture.where()
  end

  private

  def fixture_params
    params.permit(:league_table_id)
  end
end
