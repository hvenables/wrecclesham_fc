# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LeagueTable, type: :model do
  let!(:first_team_table) { create :league_table, active_first_team_table: true }
  let!(:reserve_team_table) { create :league_table, active_reserve_team_table: true }
  let!(:old_table) { create :league_table }
  context '#active_first_team_table' do
    scenario 'returns the relevant active league' do
      expect(LeagueTable.active_first_team_table).to eq first_team_table
    end
  end

  context '#active_reserve_team_table' do
    scenario 'returns the relevant active league' do
      expect(LeagueTable.active_reserve_team_table).to eq reserve_team_table
    end
  end
end
