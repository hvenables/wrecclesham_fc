require 'rails_helper'

describe TeamsHelper do
  let!(:league_table) { create :league_table }
  context '#create_teams' do
    scenario 'will create a team in the db' do
      table_data = [["UFC Farnham", "18", "13", "2", "3", "67", "31", "+36    ", "41"]]
      create_teams(table_data, league_table.id)
      ufc_farnham = Team.first
      expect(ufc_farnham.team).to eq 'UFC Farnham'
      expect(ufc_farnham.games).to eq 18
      expect(ufc_farnham.won).to eq 13
      expect(ufc_farnham.drawn).to eq 2
      expect(ufc_farnham.lost).to eq 3
      expect(ufc_farnham.goals_for).to eq 67
      expect(ufc_farnham.goals_against).to eq 31
      expect(ufc_farnham.goal_difference).to eq 36
      expect(ufc_farnham.points).to eq 41
      expect(ufc_farnham.league_table_id).to eq league_table.id
    end
  end
  context '#update_teams' do
    let!(:farnham) { create :team, team: 'UFC Farnham', league_table: league_table }
    scenario 'will update a team in the db' do
      table_data = [["UFC Farnham", "18", "13", "2", "3", "67", "31", "+36    ", "41"]]
      update_teams(table_data, league_table.id)
      ufc_farnham = Team.first
      expect(ufc_farnham.team).to eq 'UFC Farnham'
      expect(ufc_farnham.games).to eq 18
      expect(ufc_farnham.won).to eq 13
      expect(ufc_farnham.drawn).to eq 2
      expect(ufc_farnham.lost).to eq 3
      expect(ufc_farnham.goals_for).to eq 67
      expect(ufc_farnham.goals_against).to eq 31
      expect(ufc_farnham.goal_difference).to eq 36
      expect(ufc_farnham.points).to eq 41
      expect(ufc_farnham.league_table_id).to eq league_table.id
    end
  end
end
