# frozen_string_literal: true

FactoryBot.define do
  factory :fixture, class: Fixture do
    date { Date.new(2017, 1, 14) }
    association :home, factory: :team
    association :away, factory: :team
    association :competition, factory: :league_table

    factory :result do
      home_score 1
      away_score 2
    end
  end
end
