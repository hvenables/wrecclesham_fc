class LeagueTablesController < ApplicationController
  def index
    @league_tables = LeagueTable.all
  end

  def new
    @league_table = LeagueTable.new
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
    @teams = @league_table.teams.ordered_on_points
    @years = show_year(@league_table.year)
  end

  private

  def league_table_params
    params.require(:league_table).permit(:name, :year, :promoted, :relegated, :url)
  end

  def show_year(year)
    base = year.to_s.split(//).last(2).join
    next_year = (base.to_i + 1).to_s
    year.to_s + '/' + next_year
  end
end