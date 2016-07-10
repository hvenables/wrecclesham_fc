class WelcomeController < ApplicationController
  before_action :load_league, only: :index
  before_action :load_fixtures, only: :index

  def index
    @teams = @first_team_table.teams.ordered_on_points
    if @teams
      @years = show_year(@first_team_table.year)
      @teams = teams_around_us(@teams)
    end
    @news = News.all
  end

  private

  def teams_around_us(all_teams)
    first_team = Team.find_by(team: 'UFC Farnham')
    index = all_teams.to_a.index(first_team)
    numbers = []
    while numbers.length < 7
      calc_up_and_down(index, numbers) if numbers.length == 0
      numbers << numbers.last + 1
    end
    teams = []
    numbers.each do |number|
      teams << all_teams[number - 1]
    end
    teams
  end

  def calc_up_and_down(index, numbers)
    counter = index
    3.times do
      counter -= 1
      numbers << counter if counter > 0
    end
    counter = index
    3.times do
      counter += 1
      numbers << counter if counter < @teams.length
    end
    numbers << index
    numbers.sort!
  end

  def load_fixtures
  end
end
