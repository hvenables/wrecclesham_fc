# frozen_string_literal: true

class Competition
  class LeagueTablesController < ApplicationController
    load_and_authorize_resource

    def index
      @league_tables = @league_tables.order(created_at: :asc)
    end

    def new; end

    def create
      if @league_table.save
        flash[:success] = 'Successfully created league table'
        redirect_to league_table_path(@league_table)
      else
        flash[:error] = "Failed to create league table, #{@league_table.errors.full_messages.join(', ')}"
        render :new
      end
    end

    def show
      @seasons = @league_table.seasons.includes(:team).ordered_on_points if @league_table.seasons.present?
    end

    def edit; end

    def update
      if @league_table.update(league_table_params)
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
              table: Competition::LeagueTable.send("active_#{params[:table]}_table")&.id
            }
          end
        end
      end
    end

    def destroy
      @league_table = Competition::LeagueTable.find(params[:id])
      if @league_table.destroy
        flash[:notice] = 'League Table has been destroyed'
      else
        flash[:error] = "Could not delete, #{@league_table.errors.full_messages.join(', ')}"
      end
      redirect_to league_tables_path
    end

    private

    def league_table_params
      params.require(:competition_league_table).permit(
        :name,
        :abbreviation,
        :year,
        :url,
        :fixture_url,
        :result_url,
        :active
      )
    end
  end
end
