class WelcomeController < ApplicationController
  before_action :load_league, only: :index
  before_action :load_fixtures, only: :index

  def index
    LeagueTableScrapper.new.hello
  end

  private


  def load_fixtures
  end
end
