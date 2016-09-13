class FixturesController < ApplicationController
  include FixturesHelper

  def index
    @fixtures = Fixture.where(league_table_id: params[:league_table_id])
  end

  def create
    create_fixtures(params[:league_table_id])
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
