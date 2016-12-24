require 'rails_helper'

RSpec.describe LeagueTableScrapper do
  scenario 'should return teams data' do
    doc = Nokogiri::HTML(open(Rails.root + 'spec/support/league_table.html'))
    Nokogiri::HTML::Document.stub(:parse)
    Nokogiri::HTML::Document.should_receive(:parse).and_return(doc)
    result = LeagueTableScrapper.get_team_data((Rails.root + 'spec/support/league_table.html'), 12)
    #                         Pos    Team                       G    HW    HD   HL    HF    HA    AW   AD   AL   AF    AA     W     D    L    GF    GA    GD     P
    expect(result[0]).to eq  ["12", "Surrey Athletic",         "9",  "0",  "0", "4",  "8",  "25", "1", "0", "4", "12", "26", "1",  "0", "8", "20", "51", "-31", "3"]
    expect(result[1]).to eq  ["11", "Farncombe Athletic",      "10", "0",  "1", "3",  "4",  "18", "2", "0", "4", "13", "27", "2",  "1", "7", "17", "45", "-28", "7"]
    expect(result[2]).to eq  ["10", "Byfleet",                 "12", "1",  "0", "6",  "16", "27", "1", "3", "1", "14", "14", "2",  "3", "7", "30", "41", "-11", "9"]
    expect(result[3]).to eq  ["9",  "Dunsfold",                "9",  "2",  "0", "3",  "12", "19", "1", "1", "2", "5",  "7",  "3",  "1", "5", "17", "26", "-9",  "10"]
    expect(result[4]).to eq  ["8",  "Merrow A",                "11", "2",  "0", "3",  "9",  "15", "2", "0", "4", "10", "14", "4",  "0", "7", "19", "29", "-10", "12"]
    expect(result[5]).to eq  ["7",  "Wrecclesham",             "9",  "3",  "0", "3",  "19", "14", "2", "0", "1", "9",  "8",  "5",  "0", "4", "28", "22", "6",   "15"]
    expect(result[6]).to eq  ["6",  "Staines Lammas Reserves", "11", "2",  "2", "1",  "18", "7",  "2", "1", "3", "12", "17", "4",  "3", "4", "30", "24", "6",   "15"]
    expect(result[7]).to eq  ["5",  "AFC Westend Reserves",    "11", "1", "3",  "1",  "10", "13", "4", "0", "2", "25", "14", "5",  "3", "3", "35", "27", "8",   "18"]
    expect(result[8]).to eq  ["4",  "Woking Corinthians",      "10", "1", "1",  "1",  "9",  "12", "5", "0", "2", "21", "18", "6",  "1", "3", "30", "30", "0",   "19"]
    expect(result[9]).to eq  ["3",  "Deepcut Community",       "9",  "4", "0",  "1",  "24", "8",  "2", "1", "1", "18", "7",  "6",  "1", "2", "42", "15", "27",  "19"]
    expect(result[10]).to eq ["2",  "Horsley A",               "12", "5", "1",  "2",  "26", "19", "1", "1", "2", "7",  "11", "6",  "2", "4", "33", "30", "3",   "20"]
    expect(result[11]).to eq ["1",  "Hersham Vila",            "11", "5", "0",  "0",  "17", "3",  "5", "1", "0", "34", "9",  "10", "1", "0", "51", "12", "39",  "31"]
  end
end
