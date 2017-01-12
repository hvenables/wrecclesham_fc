class CupsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
    @cup = Cup.find(params[:id])
  end

  def new
    @cup = Cup.new
  end

  def create
    if Cup.create(cup_params)
      flash[:notice] = "Cup successfully created"
      redirect_to new_cup_path()
    else
      flash[:error] = "Error creating cup"
      render :new
    end
  end

  private

  def cup_params
    params.require(:cup).permit(:name, :abbreviation, :year, :fixture_url, :result_url, :team, :active)
  end

end
