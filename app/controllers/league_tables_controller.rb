class LeagueTablesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    @league_table = LeagueTable.new(league_table_params)
    if @league_table.save
      redirect_to league_table_path(@league_table)
    else
      render new
    end
  end

  def show
    @league_table = LeagueTable.find(params[:id])
    @teams = @league_table.seasons.ordered_on_points
  end

  def edit
  end

  def update
    if @league_table.update(league_table_params)
      flash[:notice] = "Succesfully updated the league table"
      redirect_to league_table_path(@league_table)
    else
      flash[:error] = "Failed to update, #{@league_table.errors.full_messages.join(', ')}"
      render :edit
    end
  end

  def destroy
    @league_table = LeagueTable.find(params[:id])
    if @league_table.destroy
      flash[:notice] = "League Table has been destroyed"
    else
      flash[:error] = "League cant be destroyed"
    end
    redirect_to league_tables_path
  end

  private

  def league_table_params
    params.require(:league_table).permit(:name, :year, :promoted, :relegated, :url, :fixture_url, :number_of_teams, :results_url)
  end

end
