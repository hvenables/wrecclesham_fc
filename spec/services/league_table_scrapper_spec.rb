require 'rails_helper'

RSpec.describe LeagueTableScrapper do
  xscenario 'should return teams data' do
    doc = Nokogiri::HTML(open(Rails.root + 'spec/support/test.html'))
    Nokogiri::HTML::Document.stub(:parse)
    Nokogiri::HTML::Document.should_receive(:parse).and_return(doc)
    result = LeagueTableScrapper.get_team_data((Rails.root + 'spec/support/test.html'), 10)
    #                         Team                           G     W    D    L     GF    GA     GD     P
    expect(result[0]).to eq ["Addlestone United",           "18", "1",  "3", "14", "18", "65", "-47", "6"]
    expect(result[1]).to eq ["Shottermill & Haslemere 'A'", "18", "3",  "1", "14", "19", "76", "-57", "10"]
    expect(result[2]).to eq ["Blackwater Royals",           "18", "5",  "2", "11", "25", "61", "-36", "17"]
    expect(result[3]).to eq ["Burpham Reserves",            "18", "5",  "4", "9",  "34", "40", "-6",  "19"]
    expect(result[4]).to eq ["Woking Corinthians",          "18", "7",  "0", "11", "35", "52", "-17", "21"]
    expect(result[5]).to eq ["Dunsfold",                    "18", "8",  "0", "10", "44", "35", "+9",  "24"]
    expect(result[6]).to eq ["Farncombe Athletic",          "18", "10", "2", "6",  "70", "43", "+27", "32"]
    expect(result[7]).to eq ["UFC Farnham",                 "18", "13", "2", "3",  "67", "31", "+36", "41"]
    expect(result[8]).to eq ["Woking Tigers",               "18", "15", "1", "2",  "70", "32", "+38", "46"]
    expect(result[9]).to eq ["Deepcut Community",           "18", "15", "1", "2",  "68", "15", "+53", "46"]
  end
end
