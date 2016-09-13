FactoryGirl.define do
  factory :season, class: Season do
    association :team, factory: :team
    games 1
    won 1
    drawn 1
    lost 1
    goals_for 10
    goals_against 10
    goal_difference 0
    points 4
    association :league_table, factory: :league_table
  end
end
