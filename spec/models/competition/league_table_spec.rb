# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Competition::LeagueTable do
  let!(:first_team_table) { create :league_table, active: true }
  let(:first_team) { create :first_team }
  let!(:reserve_team_table) { create :league_table, active: true }
  let(:reserve_team) { create :reserve_team }
  let!(:old_table) { create :league_table }

  context '.active_first_team_table' do
    subject { described_class.active_first_team_table }

    before do
      first_team_table.teams << first_team
    end

    it { is_expected.to eq first_team_table }
  end

  context '.active_reserve_team_table' do
    subject { described_class.active_reserve_team_table }

    before do
      reserve_team_table.teams << reserve_team
    end

    it { is_expected.to eq reserve_team_table }
  end

  context '#active_first_team_table?' do
    subject { first_team_table.active_first_team_table? }

    before do
      first_team_table.teams << first_team
    end

    it { is_expected.to eq true }
  end

  context '#active_reserve_team_table?' do
    subject { reserve_team_table.active_reserve_team_table? }

    before do
      reserve_team_table.teams << reserve_team
    end

    it { is_expected.to eq true }
  end
end
