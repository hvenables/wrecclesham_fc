class WelcomeController < ApplicationController
  before_action :load_league, only: :index
  before_action :load_fixtures, only: :index

  def index
    @carousel_articles = latest_carousel_items
    if @first_team_table
      @first_team_teams = @first_team_table.seasons.ordered_on_points
      @first_team_teams = teams_around_us(@first_team_teams, 'Wrecclesham')
    end
    if @reserve_team_table
      @reserve_team_teams = @reserve_team_table.seasons.ordered_on_points
      @reserve_team_teams = teams_around_us(@reserve_team_teams, 'Wrecclesham Reserves')
    end
    @news = News.all.order(updated_at: :desc).limit(5)
    @first_team_fixture = Fixture.next_game(Team.first_team)
    @reserve_team_fixture = Fixture.next_game(Team.reserve_team)
  end

  private

  def latest_carousel_items
    news = News.order(updated_at: :desc).limit(3).to_a
    videos = Video.order(updated_at: :desc).limit(2).to_a
    carousel_items = news.concat(videos)

    carousel_items.sort! do |first_item, second_item|
      second_item.created_at <=> first_item.created_at
    end

    carousel_items
  end

  def teams_around_us(all_teams, team)
    team = all_teams.find_by(team: Team.find_by(name:team))
    index = team.position
    numbers = []
    while numbers.length < 7
      calc_up_and_down(index, numbers, all_teams.length) if numbers.length == 0
      if numbers.last < all_teams.length
        numbers << numbers.last + 1
      else
        numbers << numbers.first - 1
        numbers.sort!
      end
    end
    teams = []
    numbers.each do |number|
      teams << all_teams[number - 1]
    end
    teams
  end

  def calc_up_and_down(index, numbers, league_size)
    counter = index
    3.times do
      counter -= 1
      numbers << counter if counter > 0
    end
    counter = index
    3.times do
      counter += 1
      numbers << counter if counter < league_size
    end
    numbers << index
    numbers.sort!
  end

  def load_fixtures
  end
end
