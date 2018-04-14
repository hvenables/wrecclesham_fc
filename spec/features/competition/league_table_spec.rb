# frozen_string_literal: true

require 'rails_helper'

describe Competition::LeagueTable do
  let(:admin) { create :admin }

  before do
    sign_in(admin)
  end

  context 'when no league tables' do
    it 'will display that the no league tables have been added' do
      visit root_path
      click_link 'Manage League Tables'
      expect(page).to have_content 'No League Tables have yet been added.'
      expect(page).to have_css "a.btn.btn-primary[href='/league_tables/new']", text: 'Add a league'
    end

    it 'will can create a new league table' do
      visit league_tables_path
      click_link 'Add a league'
      fill_in 'competition_league_table[name]', with: 'Test League'
      fill_in 'competition_league_table[year]', with: '2017'
      fill_in 'competition_league_table[url]', with: 'www.test.com'
      fill_in 'competition_league_table[fixture_url]', with: 'www.test.com/fixtures'
      fill_in 'competition_league_table[result_url]', with: 'www.test.com/results'
      expect { click_button 'Create League table' }.to change(described_class, :count).from(0).to(1)
      expect(page).to have_css '.alert-success', text: 'Successfully created league table'
      expect(page).to have_css 'h2', text: 'Test League - 2017/18'
    end
  end

  context 'when league tables exists' do
    let!(:league_table) { create :league_table, name: 'Test League', year: 2017, active: false }
    let!(:team_1)   { create :team, name: 'Wrecclesham' }
    let!(:season_1) { create :season, team: team_1, league_table: league_table, won: 3, points: 11 }
    let!(:team_2)   { create :team, name: 'Team 2' }
    let!(:season_2) { create :season, team: team_2, league_table: league_table }

    before do
      league_table.teams = [team_1, team_2]
    end

    it 'will allow you to view a league table' do
      visit league_table_path(league_table)
      expect(page).to have_css 'h2', text: 'Test League - 2017/18'
      expect(page).to have_css 'td', text: 'Wrecclesham'
      expect(page).to have_css 'td', text: 'Team 2'
    end

    it 'will allow you to update the details of the league' do
      visit league_table_path(league_table)
      click_link 'Edit'
      fill_in 'competition_league_table[name]', with: 'Changed Name'
      fill_in 'competition_league_table[year]', with: '2020'
      click_button 'Update League table'
      expect(page).to have_css '.alert-success', text: 'Succesfully updated the league table'
      expect(page).to have_css 'h2', text: 'Changed Name - 2020/21'
      expect(page).to have_current_path league_table_path(league_table)
    end

    it 'will not allow you invalidate a league table' do
      visit league_table_path(league_table)
      click_link 'Edit'
      fill_in 'competition_league_table[name]', with: ''
      fill_in 'competition_league_table[year]', with: '2020'
      click_button 'Update League table'
      expect(page).to have_css '.alert-warning', text: "Failed to update, Name can't be blank"
      expect(page).to have_current_path league_table_path(league_table)
    end

    it 'will allow an admin to delete a league table' do
      visit league_table_path(league_table)
      expect { click_link 'Delete Table' }.to change(described_class, :count).from(1).to(0)
      expect(page).to have_css '.alert-success', text: 'League Table has been destroyed'
    end

    context 'when active league table' do
      let!(:league_table) { create :league_table, name: 'Test League', year: 2017, active: true }

      it 'will not allow you delete an active league table' do
        visit league_table_path(league_table)
        click_link 'Delete Table'
        expect(page).to have_css '.alert-warning', text: 'Could not delete, Competition can not be deleted when an active'
      end
    end
  end
end
