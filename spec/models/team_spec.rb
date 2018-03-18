# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team, type: :model do
  let(:league_table) { create :league_table }
  context '#teams_around_team' do
    before(:each) do
      12.times do |n|
        team = create :team
        create :season, team: team, league_table: league_table, position: n + 1
        league_table.teams << team
      end
    end

    it 'will return teams below us when in first place' do
      first_place = Team.first
      expect(first_place.seven_teams_around_team).to eq Season.all[0..6]
    end
  end

  context 'creating and updating teams fixtures and results' do
    let!(:guildford_barbarians) { create :team, name: 'Guildford Barbarians' }
    let!(:hersham) { create :team, name: 'Hersham' }
    let!(:knaphill_athletic) { create :team, name: 'Knaphill Athletic' }
    let!(:burpham) { create :team, name: 'Burpham' }
    before do
      expect_any_instance_of(FixtureScrapper).to receive(:fixtures).and_return(fixture_data)
      expect_any_instance_of(FixtureScrapper).to receive(:scrap_website)
      league_table.teams = [guildford_barbarians, hersham, knaphill_athletic, burpham]
    end
    context '#create fixtures' do
      let(:fixture_data) do
        [
          ['Div4', '14/01/17 14:00', 'Guildford Barbarians', 'Hersham', 'Christs College', 'Division Four'],
          ['Div4', '14/01/17 14:00', 'Knaphill Athletic', 'Burpham', "Waterer's Park #1", 'Division Four']
        ]
      end
      it 'should create the fixtures' do
        guildford_barbarians.create_fixtures
        first_fixture = Fixture.first
        second_fixture = Fixture.last
        expect(first_fixture.home).to eq guildford_barbarians
        expect(first_fixture.away).to eq hersham
        expect(first_fixture.date).to eq Date.new(2017, 1, 14)
        expect(first_fixture.competition).to eq league_table
        expect(second_fixture.home).to eq knaphill_athletic
        expect(second_fixture.away).to eq burpham
        expect(second_fixture.date).to eq Date.new(2017, 1, 14)
        expect(second_fixture.competition).to eq league_table
      end
    end

    context '#update fixtures' do
      let!(:fixture) do
        create :fixture,
               date: Date.new(2016, 11, 19),
               home: hersham, away: burpham,
               competition: league_table
      end
      let(:fixture_data) do
        [['Div4', '19/11/16 14:00', 'Hersham', '3 - 3', 'Burpham', 'Division Four']]
      end
      it 'should update fixtures' do
        guildford_barbarians.update_fixtures
        expect(fixture.reload.home_score).to eq '3'
        expect(fixture.reload.away_score).to eq '3'
      end
    end
  end
end
