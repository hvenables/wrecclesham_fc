# frozen_string_literal: true

FactoryBot.define do
  factory :season, class: Season do
    association :team, factory: :team
    sequence(:position, &:to_s)
    games 6
    won 2
    drawn 2
    lost 2
    home_wins 1
    home_drawn 1
    home_lost 1
    home_goals_for 5
    home_goals_against 5
    away_wins 1
    away_drawn 1
    away_lost 1
    away_goals_for 5
    away_goals_against 5
    goals_for 10
    goals_against 10
    goals_difference 0
    points 8
    association :league_table, factory: :league_table
  end
end
