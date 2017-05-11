# frozen_string_literal: true

require 'rails_helper'

feature 'league table' do
  let(:admin) { create :admin }

  before(:each) do
    sign_in(admin)
  end

  context 'no league tables' do
    scenario 'display that the no league tables have been added' do
      visit root_path
      click_link 'Manage League Tables'
      expect(page).to have_content 'No League Tables have yet been added.'
      expect(page).to have_css "a.btn.btn-primary[href='/league_tables/new']", text: 'Add a league'
    end

    scenario 'can create a new league table' do
      visit league_tables_path
      click_link 'Add a league'
      fill_in 'league_table[name]', with: 'Test League'
      fill_in 'league_table[year]', with: '2017'
      fill_in 'league_table[number_of_teams]', with: '12'
      fill_in 'league_table[promoted]', with: '2'
      fill_in 'league_table[relegated]', with: '2'
      fill_in 'league_table[url]', with: 'www.test.com'
      fill_in 'league_table[fixture_url]', with: 'www.test.com/fixtures'
      fill_in 'league_table[results_url]', with: 'www.test.com/results'
      expect { click_button 'Create League table' }.to change { LeagueTable.count }.from(0).to(1)
      expect(page).to have_css '.alert-success', text: 'Successfully created league table'
      expect(page).to have_css 'h2', text: 'Test League - 2017/18'
    end
  end

  context 'league table exists' do
    let!(:league_table) { create :league_table, name: 'Test League', year: 2017 }
    # How is a team going to get updated for a new season? should test this
    let!(:team_1) { create :team, name: 'Team 1', league_table: league_table }
    let!(:season_1) { create :season, team: team_1, league_table: league_table, won: 3, points: 11 }
    let!(:team_2) { create :team, name: 'Team 2', league_table: league_table }
    let!(:season_2) { create :season, team: team_2, league_table: league_table }

    scenario 'Can view a league table' do
      visit league_table_path(league_table)
      expect(page).to have_css 'h2', text: 'Test League - 2017/18'
      expect(page).to have_css 'td', text: 'Team 1'
      expect(page).to have_css 'td', text: 'Team 2'
    end

    context 'Can update a league table' do
      scenario 'Can use update active first team and reserve team table', js: true do
        visit league_tables_path
        choose 'active_first_team_table'
        expect(page).to have_css '.alert-success', text: 'League table updated successfully'
        expect(league_table.reload.active_first_team_table).to eq true
      end

      scenario 'Try and set active league to both first and reserve team', js: true do
        visit league_tables_path
        choose 'active_first_team_table'
        choose 'active_reserve_team_table'
        expect(page).to have_css '.alert-danger', text: 'League table can only be active for first team or reserve team'
        expect(league_table.reload.active_first_team_table).to eq true
        expect(league_table.active_reserve_team_table).to eq false
      end

      scenario 'Can update the details of the league' do
        visit league_table_path(league_table)
        click_link 'Edit'
        fill_in 'league_table[name]', with: 'Changed Name'
        fill_in 'league_table[year]', with: '2020'
        click_button 'Update League table'
        expect(page).to have_css '.alert-success', text: 'Succesfully updated the league table'
        expect(page).to have_css 'h2', text: 'Changed Name - 2020/21'
        expect(current_path).to eq league_table_path(league_table)
      end

      scenario 'Bad params for update' do
        visit league_table_path(league_table)
        click_link 'Edit'
        fill_in 'league_table[name]', with: ''
        fill_in 'league_table[year]', with: '2020'
        click_button 'Update League table'
        expect(page).to have_css '.alert-warning', text: "Failed to update, Name can't be blank"
        expect(current_path).to eq league_table_path(league_table)
      end

      scenario 'Can delete a league table' do
        visit league_table_path(league_table)
        expect { click_link 'Delete Table' }.to change { LeagueTable.count }.from(1).to(0)
        expect(page).to have_css '.alert-success', text: 'League Table has been destroyed'
      end

      context 'active league table' do
        let!(:league_table) { create :league_table, name: 'Test League', year: 2017, active_first_team_table: true }
        scenario 'Delete an active league table' do
          visit league_table_path(league_table)
          click_link 'Delete Table'
          expect(page).to have_css '.alert-warning', text: 'Could not delete, League table can not be deleted when an active league table'
        end
      end
    end
  end
end
