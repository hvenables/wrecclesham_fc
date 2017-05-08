# frozen_string_literal: true

FactoryGirl.define do
  factory :team, class: Team do
    sequence(:name) { |n| "Team #{n}" }
    league_table
  end
end
