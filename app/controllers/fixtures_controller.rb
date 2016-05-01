class FixturesController < ApplicationController
  include FixturesHelper

  before_action :load_league, only: :create

  def index
    @fixtures = Fixture.all
  end

  def create
    date_and_fixtures = Fixture.get_fixtures(@league_table.fixture_url)
    create_fixtures(date_and_fixtures[0], date_and_fixtures[1], params[:league_table_id])
    redirect_to league_table_fixtures_path(params[:league_table_id])
  end

  private

  def load_league
    @league_table = LeagueTable.find(params[:league_table_id][0])
  end
end
