class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :load_league

  private

  def load_league
    @first_team_table = LeagueTable.find(1)
    @reserve_team_table = LeagueTable.find(2)
  end

end
