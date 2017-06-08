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

    scenario 'Diplay fixtures in league', js: true do
      visit league_table_fixtures_path(league)
      click_link 'Fixtures'
      within('.active.tab-pane') do
        expect(page).to have_css 'li.list-group-item.dark-color', text: (Date.today + 1.week).strftime('%a, %d %b %Y')
        expect(page).to have_css 'li.list-group-item', count: 3
      end
    end

    scenario 'Display results in league', js: true do
      visit league_table_fixtures_path(league)
      click_link 'Results'
      within('.active.tab-pane') do
        expect(page).to have_css 'li.list-group-item.dark-color', text: (Date.today - 1.week).strftime('%a, %d %b %Y')
        expect(page).to have_css 'li.list-group-item', count: 3
      end
    end
  end

  context 'Create and Update fixtures' do
    let!(:guildford_barbarians) { create :team, name: 'Guildford Barbarians', league_table: league }
    let!(:hersham) { create :team, name: 'Hersham', league_table: league }
    let!(:knaphill_athletic) { create :team, name: 'Knaphill Athletic', league_table: league }
    let!(:burpham) { create :team, name: 'Burpham', league_table: league }

    before do
      expect_any_instance_of(FixtureScrapper).to receive(:fixtures).and_return(fixture_data)
      expect_any_instance_of(FixtureScrapper).to receive(:scrap_website)
    end

    context 'Create Fixtures' do
      let(:fixture_data) do
        [
          ['Div4', (Date.today.beginning_of_week(:saturday) + 1.week).strftime('%d/%m/%y %H:%M'), 'Guildford Barbarians', 'Hersham', 'Christs College', 'Division Two'],
          ['Div4', (Date.today.beginning_of_week(:saturday) + 1.week).strftime('%d/%m/%y %H:%M'), 'Knaphill Athletic', 'Burpham', "Waterer's Park #1", 'Division Two']
        ]
      end
      scenario 'Can create new fixtures', js: true do
        visit team_fixtures_path(guildford_barbarians)
        click_link 'Add Fixtures'
        click_link 'Fixtures'
        within('.active.tab-pane') do
          expect(page).to have_css 'td', text: (Date.today.beginning_of_week(:saturday) + 1.week).strftime('%a, %d %b %Y')
          expect(page).to have_css 'td', text: 'Guildford Barbarians'
          expect(page).to have_css 'td', text: 'Div2'
        end
        expect(page).to have_css '.alert-success', text: 'Fixtures have been created'
        expect(current_path).to eq team_fixtures_path(guildford_barbarians)
      end
    end

    context 'Update Fixtures' do
      let!(:fixture) do
        create(
          :fixture,
          date: Date.today.beginning_of_week(:saturday),
          home: guildford_barbarians,
          away: burpham,
          competition: league
        )
      end
      let(:fixture_data) do
        [['Div4', Date.today.beginning_of_week(:saturday).strftime('%d/%m/%y %H:%M'), 'Guildford Barbarians', '3 - 3', 'Burpham', 'Division Four']]
      end

      scenario 'Can update existing fixtures', js: true do
        visit team_fixtures_path(guildford_barbarians)
        click_link 'Add Results'
        click_link 'Results'
        within('.active.tab-pane') do
          expect(page).to have_css 'td', text: Date.today.beginning_of_week(:saturday).strftime('%a, %d %b %Y')
          expect(page).to have_css 'td', text: 'Guildford Barbarians'
          expect(page).to have_css 'td', text: '3 - 3'
          expect(page).to have_css 'td', text: 'Div2'
        end
      end
    end
  end
end
