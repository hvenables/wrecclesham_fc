class WelcomeController < ApplicationController

  def index
    @carousel_articles = latest_carousel_items
    @first_team_teams = @first_team.seven_positions_around_team if @first_team_table
    @reserve_team_teams = @reserve_team.seven_positions_around_team if @reserve_team_table
    if @first_team.present?
      @first_team_fixture, @first_team_result = @first_team.last_game, @first_team.next_game
    end
    if @reserve_team.present?
      @reserve_team_fixture, @reserve_team_result = @reserve_team.next_game, @reserve_team.last_game
    end
    @twitter = TwitterFeed.new
  end

  private

  def latest_carousel_items
    news = News.order(created_at: :desc).limit(6).to_a
    videos = Video.order(created_at: :desc).limit(2).to_a
    carousel_items = news + videos

    carousel_items.sort! do |first_item, second_item|
      second_item.created_at <=> first_item.created_at
    end

    carousel_items
  end

end
