class WelcomeController < ApplicationController
  before_action :load_league, only: :index

  def index
    @carousel_articles = latest_carousel_items
    if @first_team_table
      @first_team_teams = Team.first_team.seven_positions_around_team
    end
    if @reserve_team_table
      @reserve_team_teams = Team.reserve_team.seven_positions_around_team
    end
    @news = News.all.order(updated_at: :desc).limit(5)
    @first_team_fixture = Fixture.next_game(Team.first_team)
    @reserve_team_fixture = Fixture.next_game(Team.reserve_team)
  end

  private

  def latest_carousel_items
    news = News.order(updated_at: :desc).limit(5).to_a
    videos = Video.order(updated_at: :desc).limit(2).to_a
    carousel_items = news.concat(videos)

    carousel_items.sort! do |first_item, second_item|
      second_item.created_at <=> first_item.created_at
    end

    carousel_items
  end
end
