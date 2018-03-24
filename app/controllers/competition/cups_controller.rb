# frozen_string_literal: true

class Competition::CupsController < ApplicationController
  load_and_authorize_resource

  before_action :load_cup_teams, only: %i[create update]

  def index; end

  def new; end

  def create
    @cup_teams.each { |team| @cup.teams << team unless @cup.teams.include?(team) }
    if @cup.save
      flash[:notice] = 'Cup successfully created'
      redirect_to cups_path
    else
      flash[:error] = "Failed to create cup, #{@cup.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def edit; end

  def update
    @cup_teams.each { |team| @cup.teams << team unless @cup.teams.include?(team) }
    if @cup.update(cup_params)
      respond_to do |format|
        format.html do
          flash[:notice] = 'Cup successfully updated'
          redirect_to cups_path
        end
        format.json { render json: { success: true } }
      end
    else
      respond_to do |format|
        format.html do
          flash[:error] = "Failed to update, #{@cup.errors.full_messages.join(', ')}"
          render :edit
        end
        format.json do
          render json: { errors: @cup.errors }
        end
      end
    end
  end

  private

  def cup_params
    params.require(:competition_cup).permit(:name, :abbreviation, :year, :fixture_url, :result_url, :active)
  end

  def load_cup_teams
    @cup_teams = Team.where(id: params[:teams])
  end
end
