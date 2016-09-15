class WelcomeController < ApplicationController
  before_action :load_league, only: :index
  before_action :load_fixtures, only: :index

  def index
    if @first_team_table
      @first_team_teams = @first_team_table.seasons.ordered_on_points
      @first_team_teams = teams_around_us(@first_team_teams, 'Wrecclesham')
    end
    if @reserve_team_table
      @reserve_team_teams = @reserve_team_table.seasons.ordered_on_points
      @reserve_team_teams = teams_around_us(@reserve_team_teams, 'Wrecclesham Reserves')
    end
    @news = News.all
  end

  private

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
