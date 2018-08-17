# frozen_string_literal: true

FactoryBot.define do
  factory :cup, class: Competition::Cup do
    year { 2017 }
    name { 'Test Cup' }
    abbreviation { 'TC' }
    fixture_url { 'www.test.com/fixtures' }
    result_url { 'www.test.com/results' }
    active { true }
  end
end
