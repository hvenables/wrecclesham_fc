# frozen_string_literal: true

require 'rails_helper'

describe 'fixtures' do
  let(:admin) { create :admin }
  let!(:team) { create :team, name: 'Wrecclesham' }
  let!(:league) { create :league_table, active: true }
  let!(:fixture) { create :fixture, date: (Date.today + 1.week), home: team, competition: league }
  let!(:result) { create :fixture, date: (Date.today - 1.week), home: team, competition: league, home_score: '1', away_score: '0' }
  let!(:season) { create :season, team: team, league_table: league }
  let!(:other_fixture) { create :fixture, date: (Date.today + 1.week) }
  let!(:other_result) { create :fixture, date: (Date.today - 1.week), home_score: '2', away_score: '0' }

  before do
    sign_in(admin)

    team.competitions << league
  end

  context 'when displaying fixtures and results', js: true do
    it 'will display results for only wrecclesham' do
      visit team_fixtures_path(team)
      click_link 'Fixtures'
      within('.active.tab-pane') do
        expect(page).to have_css 'td', text: (Date.today + 1.week).strftime('%a, %d %b %Y')
        expect(page).to have_css 'td', text: 'Wrecclesham'
        expect(page).to have_css 'td', text: 'Div2'
      end
    end

    it 'will display results for only wrecclesham' do
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

  context 'when displaying league fixtures and results' do
    let!(:league_fixture) { create :fixture, date: (Date.today + 1.week), competition: league }
    let!(:league_result) { create :fixture, date: (Date.today - 1.week), home_score: '2', away_score: '0', competition: league }

    it 'will display all fixtures in the league', js: true do
      visit league_table_fixtures_path(league)
      click_link 'Fixtures'
      within('.active.tab-pane') do
        expect(page).to have_css 'td', text: (Date.today + 1.week).strftime('%a, %d %b %Y')
        expect(page).to have_css 'td', text: 'Wrecclesham'
        expect(page).to have_css 'td', text: 'Div2'
      end
    end

    it 'will display all the results in the league', js: true do
      visit league_table_fixtures_path(league)
      click_link 'Results'
      within('.active.tab-pane') do
        expect(page).to have_css 'td', text: (Date.today - 1.week).strftime('%a, %d %b %Y')
        expect(page).to have_css 'td', text: 'Wrecclesham'
        expect(page).to have_css 'td', text: '1 - 0'
        expect(page).to have_css 'td', text: 'Div2'
      end
    end
  end

  context 'when creating and updating fixtures' do
    let!(:guildford_barbarians) { create :team, name: 'Guildford Barbarians' }
    let!(:hersham) { create :team, name: 'Hersham' }
    let!(:knaphill_athletic) { create :team, name: 'Knaphill Athletic' }
    let!(:burpham) { create :team, name: 'Burpham' }

    before do
      expect(FixtureScrapper).to receive(:fixtures).and_return(fixture_data)
      league.teams = [guildford_barbarians, hersham, knaphill_athletic, burpham]
    end

    context 'with fixture date' do
      let(:fixture_data) do
        [
          [(Date.today.beginning_of_week(:saturday) + 1.week).strftime('%d/%m/%y %H:%M'), 'Guildford Barbarians', 'Hersham', 'Christs College', 'Division Two'],
          [(Date.today.beginning_of_week(:saturday) + 1.week).strftime('%d/%m/%y %H:%M'), 'Knaphill Athletic', 'Burpham', "Waterer's Park #1", 'Division Two']
        ]
      end

      it 'will create new fixtures', js: true do
        visit team_fixtures_path(guildford_barbarians)
        click_link 'Add Fixtures'
        expect(page).to have_css 'td', text: (Date.today.beginning_of_week(:saturday) + 1.week).strftime('%a, %d %b %Y')
        expect(page).to have_css 'td', text: 'Guildford Barbarians'
        expect(page).to have_css 'td', text: 'Div2'
        expect(page).to have_css '.alert-success', text: 'Fixtures have been created'
        expect(page).to have_current_path team_fixtures_path(guildford_barbarians)
      end
    end

    context 'with result data' do
      let!(:fixture) do
        create(
          :fixture,
          date: (Time.zone.today + 1.week),
          home: guildford_barbarians,
          away: burpham,
          competition: league
        )
      end
      let(:fixture_data) do
        [[(Time.zone.today + 1.week).strftime('%d/%m/%y %H:%M'), 'Guildford Barbarians', '3 - 3', 'Burpham', 'Division Four']]
      end

      it 'will update existing fixtures' do
        visit team_fixtures_path(guildford_barbarians)
        click_link 'Add Results'
        expect(page).to have_css 'td', text: (Time.zone.today + 1.week).strftime('%a, %d %b %Y')
        expect(page).to have_css 'td', text: 'Guildford Barbarians'
        expect(page).to have_css 'td', text: '3 - 3'
        expect(page).to have_css 'td', text: 'Div2'
      end
    end
  end
end
