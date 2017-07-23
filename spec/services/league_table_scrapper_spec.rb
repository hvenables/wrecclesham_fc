# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LeagueTableScrapper do
  scenario 'should return teams data' do
    result = LeagueTableScrapper.get_team_data(Rails.root + 'spec/fixtures/league_table.html')
    #              Team                               Pos G  HW D L F  A AW D L F  A  W  D L GF GA GD  P
    expect(result['Surrey Athletic']).to eq         %w[12 9  0  0 4 8  25 1 0 4 12 26 1  0 8 20 51 -31 3]
    expect(result['Farncombe Athletic']).to eq      %w[11 10 0  1 3 4  18 2 0 4 13 27 2  1 7 17 45 -28 7]
    expect(result['Byfleet']).to eq                 %w[10 12 1  0 6 16 27 1 3 1 14 14 2  3 7 30 41 -11 9]
    expect(result['Dunsfold']).to eq                %w[9  9  2  0 3 12 19 1 1 2 5  7  3  1 5 17 26 -9  10]
    expect(result['Merrow A']).to eq                %w[8  11 2  0 3 9  15 2 0 4 10 14 4  0 7 19 29 -10 12]
    expect(result['Wrecclesham']).to eq             %w[7  9  3  0 3 19 14 2 0 1 9  8  5  0 4 28 22 6   15]
    expect(result['Staines Lammas Reserves']).to eq %w[6  11 2  2 1 18 7  2 1 3 12 17 4  3 4 30 24 6   15]
    expect(result['AFC Westend Reserves']).to eq    %w[5  11 1  3 1 10 13 4 0 2 25 14 5  3 3 35 27 8   18]
    expect(result['Woking Corinthians']).to eq      %w[4  10 1  1 1 9  12 5 0 2 21 18 6  1 3 30 30 0   19]
    expect(result['Deepcut Community']).to eq       %w[3  9  4  0 1 24 8  2 1 1 18 7  6  1 2 42 15 27  19]
    expect(result['Horsley A']).to eq               %w[2  12 5  1 2 26 19 1 1 2 7  11 6  2 4 33 30 3   20]
    expect(result['Hersham Vila']).to eq            %w[1  11 5  0 0 17 3  5 1 0 34 9  10 1 0 51 12 39  31]
  end
end
