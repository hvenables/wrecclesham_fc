# frozen_string_literal: true

FactoryBot.define do
  factory :league_table, class: Competition::LeagueTable do
    year { 2015 }
    name { 'MyString' }
    abbreviation { 'Div2' }
    url { 'www.test.com' }
    fixture_url { 'www.test.com/fixtures' }
    result_url { 'www.test.com/results' }
    active { true }
  end
end
