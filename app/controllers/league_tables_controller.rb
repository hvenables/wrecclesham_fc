# frozen_string_literal: true

class LeagueTablesController < ApplicationController
  load_and_authorize_resource

  def index; end

  def new; end

  def create
    @league_table = LeagueTable.new(league_table_params)
    if @league_table.save
      flash[:success] = 'Successfully created league table'
      redirect_to league_table_path(@league_table)
    else
      flash[:error] = "Failed to create league table, #{@league_table.errors.full_messages.join(', ')}"
      render new
    end
  end

  def show
    @teams = @league_table.seasons.ordered_on_points if @league_table.seasons.present?
  end

  def edit; end

  def update
    if @league_table.update(league_table_params)
      @league_table.set_active_league(league_table_params, params[:id])
      respond_to do |format|
        format.html do
          flash[:notice] = 'Succesfully updated the league table'
          redirect_to league_table_path(@league_table)
        end
        format.json { render json: { success: true } }
      end
    else
      respond_to do |format|
        format.html do
          flash[:error] = "Failed to update, #{@league_table.errors.full_messages.join(', ')}"
          render :edit
        end
        format.json do
          render json: {
            errors: @league_table.errors,
            table: LeagueTable.send("active_#{params[:table]}_table")&.id
          }
        end
      end
    end
  end

  def destroy
    @league_table = LeagueTable.find(params[:id])
    if @league_table.destroy
      flash[:notice] = 'League Table has been destroyed'
    else
      flash[:error] = "Could not delete, #{@league_table.errors.full_messages.join(', ')}"
    end
    redirect_to league_tables_path
  end

  private

  def league_table_params
    params.require(:league_table).permit(
      :name,
      :year,
      :promoted,
      :relegated,
      :url,
      :fixture_url,
      :number_of_teams,
      :results_url,
      :active_first_team_table,
      :active_reserve_team_table
    )
  end
end
