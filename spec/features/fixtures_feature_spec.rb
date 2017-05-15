# frozen_string_literal: true

require 'rails_helper'

feature 'fixtures' do
  let(:admin) { create :admin }
  let!(:team) { create :team, name: 'Wrecclesham', league_table: league }
  let!(:league) { create :league_table, active_first_team_table: true }
  let!(:fixture) { create :fixture, date: (Date.today + 1.week), home: team, competition: league }
  let!(:result) { create :fixture, date: (Date.today - 1.week), home: team, competition: league, home_score: '1', away_score: '0' }
  let!(:season) { create :season, team: team, league_table: league }
  let!(:other_fixture) { create :fixture, date: (Date.today + 1.week) }
  let!(:other_result) { create :fixture, date: (Date.today - 1.week), home_score: '2', away_score: '0' }

  before(:each) do
    sign_in(admin)
  end

  context 'Display team fixtures and results', js: true do
    scenario 'display results for only wrecclesham' do
      visit team_fixtures_path(team)
      click_link 'Fixtures'
      within('.active.tab-pane') do
        expect(page).to have_css 'td', text: (Date.today + 1.week).strftime('%a, %d %b %Y')
        expect(page).to have_css 'td', text: 'Wrecclesham'
        expect(page).to have_css 'td', text: 'Div2'
      end
    end

    scenario 'display results for only wrecclesham' do
      visit team_fixtures_path(team)
      click_link 'Results'
      within('.active.tab-pane') do
        expect(page).to have_css 'td', text: (Date.today - 1.week).strftime('%a, %d %b %Y')
        expect(page).to have_css 'td', text: 'Wrecclesham'
        expect(page).to have_css 'td', text: '1 - 0'
        expect(page).to have_css 'td', text: 'Div2'
      end
    end
  end

  context 'Display league fixtures and results' do
    let!(:league_fixture) { create :fixture, date: (Date.today + 1.week), competition: league }
    let!(:league_result) { create :fixture, date: (Date.today - 1.week), home_score: '2', away_score: '0', competition: league }
    scenario 'diplay fixtures in league', js: true do
      visit league_table_fixtures_path(league)
      click_link 'Fixtures'
      within('.active.tab-pane') do
        expect(page).to have_css 'li.list-group-item.dark-color', text: (Date.today + 1.week).strftime('%a, %d %b %Y')
        expect(page).to have_css 'li.list-group-item', count: 3
      end
    end

    scenario 'diplay results in league', js: true do
      visit league_table_fixtures_path(league)
      click_link 'Results'
      within('.active.tab-pane') do
        expect(page).to have_css 'li.list-group-item.dark-color', text: (Date.today - 1.week).strftime('%a, %d %b %Y')
        expect(page).to have_css 'li.list-group-item', count: 3
      end
    end
  end
end
