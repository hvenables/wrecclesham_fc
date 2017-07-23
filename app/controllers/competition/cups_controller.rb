# frozen_string_literal: true

class Competition::CupsController < ApplicationController
  load_and_authorize_resource

  def index; end

  def new; end

  def create
    @cup.teams << Team.find_by(id: params[:teams])
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
    team = Team.find_by(id: params[:teams])
    @cup.teams << team unless @cup.teams.include?(team)
    if @cup.update(cup_params)
      flash[:notice] = 'Cup successfully updated'
      redirect_to cups_path
    else
      flash[:error] = 'Error updating cup'
      render :edit
    end
  end

  private

  def cup_params
    params.require(:cup).permit(:name, :abbreviation, :year, :fixture_url, :results_url, :active)
  end
end
