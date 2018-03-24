# frozen_string_literal: true

module FeatureMatchers
  def have_fixture(fixture)
    have_css('td.text-center', text: fixture.date) &&
      have_css('td.text-center', text: fixture.home.name) &&
      have_css('td.text-center', text: fixture.home.name) &&
      have_css('td.text-center', text: fixture.competition.abbreviation)
  end

  def have_result(fixture)
    have_fixture(fixture) &&
      have_css('td.text-center', text: "#{fixture.home_score} - #{fixture.away_score}")
  end
end
