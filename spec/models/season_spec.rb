# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Season, type: :model do
  let!(:league_table) { create :league_table }
  let!(:wrecclesham) { create :team, name: 'Wrecclesham', league_table: league_table }
  context '#create_teams' do
    scenario 'will create a team in the db' do
      table_data = [['1', 'Wrecclesham', '18', '3', '3', '3', '31',
                     '20', '3', '3', '3', '31', '20', '6', '6', '6', '62',
                     '40', '', '24']]
      Season.create_teams(table_data, league_table.id)
      season = Season.first
      expect(season.team).to eq wrecclesham
      expect(season.games).to eq 18
      expect(season.won).to eq 6
      expect(season.drawn).to eq 6
      expect(season.lost).to eq 6
      expect(season.goals_for).to eq 62
      expect(season.goals_against).to eq 40
      expect(season.goals_difference).to eq 22
      expect(season.points).to eq 24
      expect(season.league_table_id).to eq league_table.id
    end
  end

  context '#update_teams' do
    let!(:season) { create :season, team: wrecclesham, league_table: league_table }
    scenario 'will update a team in the db' do
      table_data = [['1', 'Wrecclesham', '18', '3', '3', '3', '31',
                     '20', '3', '3', '3', '31', '20', '6', '6', '6', '62',
                     '40', '', '24']]
      Season.update_teams(table_data, league_table.id)
      current_season = Season.first
      expect(current_season.team).to eq wrecclesham
      expect(current_season.games).to eq 18
      expect(current_season.won).to eq 6
      expect(current_season.drawn).to eq 6
      expect(current_season.lost).to eq 6
      expect(current_season.goals_for).to eq 62
      expect(current_season.goals_against).to eq 40
      expect(current_season.goals_difference).to eq 22
      expect(current_season.points).to eq 24
      expect(current_season.league_table_id).to eq league_table.id
    end
  end
end
