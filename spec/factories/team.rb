FactoryGirl.define do
  factory :team, class: Team do
    team 'Team'
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
