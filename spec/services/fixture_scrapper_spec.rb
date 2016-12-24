require 'rails_helper'

RSpec.describe FixtureScrapper do
  context 'Fixtures' do
    scenario 'Will return an array of fixtures' do
      fixture = FixtureScrapper.get_fixtures_data((Rails.root + 'spec/fixtures/test_fixtures.html'))
      #                           Abbr    Date                   Home                       Away                             Venue                         Competition
      expect(fixture[0]).to eq  ['IntC', 'TBC',            "Laleham Athletic",        "Surrey Athletic",           "Egham Leisure Centre #2",           "Intermediate Cup"]
      expect(fixture[1]).to eq  ["IntC", "TBC",            "Staines Lammas Reserves", "Windlesham & Lightwater A", "Littleton Recreation Ground",       "Intermediate Cup"]
      expect(fixture[2]).to eq  ["IntC", "TBC",            "Woking Tigers",           "Wrecclesham",               "West Byfleet Recreation Ground #1", "Intermediate Cup"]
      expect(fixture[3]).to eq  ["IntC", "TBC",            "Horsley A",               "AFC Westend Reserves",      "Tom's Field",                       "Intermediate Cup"]
      expect(fixture[4]).to eq  ["IntC", "TBC",            "Laleham Reserves",        "Byfleet",                   "The Lucan Pavilion",                "Intermediate Cup"]
      expect(fixture[5]).to eq  ["Div2", "07/01/17 14:00", "Byfleet",                 "Dunsfold",                  "Byfleet Recreation Ground",         "Division Two"]
      expect(fixture[6]).to eq  ["Div2", "07/01/17 14:00", "Farncombe Athletic",      "Deepcut Community",         "Broadwater School",                 "Division Two"]
      expect(fixture[7]).to eq  ["Div2", "07/01/17 14:00", "Staines Lammas Reserves", "Horsley A",                 "Littleton Recreation Ground",       "Division Two"]
      expect(fixture[8]).to eq  ["Div2", "07/01/17 14:00", "Surrey Athletic",         "Merrow A",                  "Bisley Recreation Ground",          "Division Two"]
      expect(fixture[9]).to eq  ["Div2", "07/01/17 14:00", "Wrecclesham",             "AFC Westend Reserves",      "Wrecclesham Recreation Ground",     "Division Two"]
      expect(fixture[10]).to eq ["SLJC", "07/01/17 13:30", "Perrywood Sports (Seniors) First", "Hersham Vila",     "***To be confirmed by club***",     "Surrey County FA Lower Junior Cup"]
      expect(fixture[11]).to eq ["Div2", "14/01/17 14:00", "Farncombe Athletic",      "Surrey Athletic",           "Broadwater School",                 "Division Two"]
      expect(fixture[12]).to eq ["Div2", "14/01/17 14:00", "Hersham Vila",            "Wrecclesham",               "St. George's College",              "Division Two"]
      expect(fixture[13]).to eq ["Div2", "14/01/17 14:00", "Horsley A",               "AFC Westend Reserves",      "Tom's Field",                       "Division Two"]
      expect(fixture[14]).to eq ["Div2", "14/01/17 14:00", "Merrow A",                "Deepcut Community",         "Urnfield #1",                       "Division Two"]
    end
  end
end
