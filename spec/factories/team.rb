# frozen_string_literal: true

FactoryBot.define do
  factory :team, class: Team do
    sequence(:name) { |n| "Team #{n}" }

    factory :first_team do
      name { 'Wrecclesham' }
    end

    factory :reserve_team do
      name { 'Wrecclesham Reserves' }
    end
  end
end
