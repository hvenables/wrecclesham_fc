class WelcomeController < ApplicationController
  before_action :load_league, only: :index
  before_action :load_fixtures, only: :index

  def index

  end

  private


  def load_fixtures
  end
end
