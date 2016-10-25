require 'rails_helper'

RSpec.describe Team, type: :model do
  let(:league_table) { FactoryGirl.create :league_table }
  before(:each) do
    12.times do |n|
      team = FactoryGirl.create :team, league_table: league_table
      FactoryGirl.create :season, team: team, league_table: league_table, position: n
    end
  end

  context '#teams_around_team' do
    it 'will return teams below us when in first place' do
      first_place = Team.first
      expect(first_place.seven_positions_around_team).to eq Season.all[0..6]
    end
  end
end
