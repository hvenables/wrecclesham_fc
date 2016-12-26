FactoryGirl.define do
  factory :fixture, class: Fixture do
    date Date.new(2017, 1, 14)
    association :home, factory: :team
    association :away, factory: :team
    association :league_table, factory: :league_table

    factory :result do
      home_score 1
      away_score 2
    end
  end
end
