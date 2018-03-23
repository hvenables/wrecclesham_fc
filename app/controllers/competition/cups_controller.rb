# frozen_string_literal: true

class Competition::CupsController < ApplicationController
  load_and_authorize_resource

  before_action :load_team, only: %i[create update]

  def index; end

  def new; end

  def create
    @cup.teams << @team
    if @cup.save
      flash[:notice] = 'Cup successfully created'
      redirect_to cups_path
    else
      flash[:error] = 'Error creating cup'
      render :new
    end
  end

  def edit; end

  def update
    @cup.teams << team if @team && !@cup.teams.include?(@team)
    if @cup.update(cup_params)
      respond_to do |format|
        format.html do
          flash[:notice] = 'Cup successfully updated'
          redirect_to cups_path
        end
        format.json { render json: { success: true } }
      end
    else
      flash[:error] = 'Error updating cup'
      render :edit
    end
  end

  private

  def cup_params
    params.require(:competition_cup).permit(:name, :abbreviation, :year, :fixture_url, :results_url, :active)
  end

  def load_team
    @team = Team.find_by(id: params[:teams])
  end
end
