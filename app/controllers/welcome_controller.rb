# frozen_string_literal: true

class WelcomeController < ApplicationController
  before_action :load_articles

  def index
    @first_team_teams = @first_team.seven_teams_around_team if @first_team_table
    @reserve_team_teams = @reserve_team.seven_teams_around_team if @reserve_team_table
    if @first_team.present?
      @first_team_fixture = @first_team.next_game
      @first_team_result = @first_team.last_game
    end
    if @reserve_team.present?
      @reserve_team_fixture = @reserve_team.next_game
      @reserve_team_result = @reserve_team.last_game
    end
    @twitter = TwitterFeed.new
  end

  private

  def load_articles
    @latest_articles     = News.order(id: :desc).limit(4)

    @main_article        = @latest_articles.first
    @supporting_articles = @latest_articles[1..3]
  end

end
