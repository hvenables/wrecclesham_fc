# frozen_string_literal: true

require 'rails_helper'

feature 'fixtures' do
  let(:admin) { create :admin }
  let!(:team) { create :team, name: 'Wrecclesham', league_table: league }
  let!(:league) { create :league_table, active_first_team_table: true }
  let!(:fixture) { create :fixture, date: (Date.today + 1.week), home: team, competition: league }
  let!(:result) { create :fixture, date: (Date.today - 1.week), home: team, competition: league }
  let!(:season) { create :season, team: team, league_table: league }

  before(:each) do
    sign_in(admin)
  end

  scenario 'should display fixtures for only wrecclesham', js: true do
    visit team_fixtures_path(team)
    click_link 'Results'
  end
end
