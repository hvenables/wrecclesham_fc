require 'rails_helper'

RSpec.describe Fixture, type: :model do
  let!(:league_table) { create :league_table }
  let!(:guildford_barbarians) { create :team, name: "Guildford Barbarians"}
  let!(:hersham) { create :team, name: "Hersham"}
  let!(:knaphill_athletic) { create :team, name: "Knaphill Athletic"}
  let!(:burpham) { create :team, name: "Burpham"}

  before do
    expect(FixtureScrapper).to receive(:get_fixtures_data).and_return(fixture_data)
  end

  context '#create fixtures' do
    let(:fixture_data) {
      [
        ["Div4", "14/01/17 14:00", "Guildford Barbarians", "Hersham", "Christs College", "Division Four"],
        ["Div4", "14/01/17 14:00", "Knaphill Athletic", "Burpham", "Waterer's Park #1", "Division Four"]
      ]
    }
    it 'should create the fixtures' do
      Fixture.create_fixtures(league_table.id)
      first_fixture = Fixture.first
      second_fixture = Fixture.last
      expect(first_fixture.home).to eq guildford_barbarians
      expect(first_fixture.away).to eq hersham
      expect(first_fixture.date).to eq Date.new(2017, 1, 14)
      expect(first_fixture.league_table).to eq league_table
      expect(second_fixture.home).to eq knaphill_athletic
      expect(second_fixture.away).to eq burpham
      expect(second_fixture.date).to eq Date.new(2017, 1, 14)
      expect(second_fixture.league_table).to eq league_table
    end
  end

  context '#update fixtures' do
    let!(:fixture) {
      create :fixture,
      date: Date.new(2016, 11, 19),
      home: hersham, away: burpham,
      league_table: league_table
    }
    let(:fixture_data) {
      [["Div4", "19/11/16 14:00", "Hersham", "3 - 3", "Burpham", "Division Four"]]
    }
    it 'should update fixtures' do
      Fixture.update_fixtures(league_table.id)
      expect(fixture.reload.home_score).to eq "3"
      expect(fixture.reload.away_score).to eq "3"
    end
  end
end
