FactoryGirl.define do
  factory :league_table, class: LeagueTable do
    year 2015
    name "MyString"
    promoted 2
    relegated 2
    url "MyString"
    fixture_url "MyString"
    number_of_teams 10
    active_first_team_table false
    active_reserve_team_table false
  end
end
