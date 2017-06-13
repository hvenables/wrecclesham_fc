# frozen_string_literal: true

FactoryGirl.define do
  factory :cup do
    year 2017
    name 'Test Cup'
    abbreviation 'TC'
    fixture_url 'www.test.com/fixtures'
    results_url 'www.test.com/results'
    active true
  end
end
