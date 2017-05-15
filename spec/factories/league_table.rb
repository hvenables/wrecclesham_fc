# frozen_string_literal: true

FactoryGirl.define do
  factory :league_table, class: LeagueTable do
    year 2015
    name 'MyString'
    abbreviation 'Div2'
    promoted 2
    relegated 2
    url 'www.test.com'
    fixture_url 'www.test.com/fixtures'
    results_url 'www.test.com/results'
    number_of_teams 10
    active_first_team_table false
    active_reserve_team_table false
  end
end
