# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FixtureScrapper do
  context 'Fixtures' do
    scenario 'Will return an array of fixtures' do
      fixture = FixtureScrapper.new(Rails.root + 'spec/fixtures/test_fixtures.html').fixtures
      #                           Abbr    Date                   Home                       Away                             Venue                         Competition
      expect(fixture[0]).to eq  ['IntC', 'TBC',            'Laleham Athletic',        'Surrey Athletic',           'Egham Leisure Centre #2',           'Intermediate Cup']
      expect(fixture[1]).to eq  ['IntC', 'TBC',            'Staines Lammas Reserves', 'Windlesham & Lightwater A', 'Littleton Recreation Ground',       'Intermediate Cup']
      expect(fixture[2]).to eq  ['IntC', 'TBC',            'Woking Tigers',           'Wrecclesham',               'West Byfleet Recreation Ground #1', 'Intermediate Cup']
      expect(fixture[3]).to eq  ['IntC', 'TBC',            'Horsley A',               'AFC Westend Reserves',      "Tom's Field",                       'Intermediate Cup']
      expect(fixture[4]).to eq  ['IntC', 'TBC',            'Laleham Reserves',        'Byfleet',                   'The Lucan Pavilion',                'Intermediate Cup']
      expect(fixture[5]).to eq  ['Div2', '07/01/17 14:00', 'Byfleet',                 'Dunsfold',                  'Byfleet Recreation Ground',         'Division Two']
      expect(fixture[6]).to eq  ['Div2', '07/01/17 14:00', 'Farncombe Athletic',      'Deepcut Community',         'Broadwater School',                 'Division Two']
      expect(fixture[7]).to eq  ['Div2', '07/01/17 14:00', 'Staines Lammas Reserves', 'Horsley A',                 'Littleton Recreation Ground',       'Division Two']
      expect(fixture[8]).to eq  ['Div2', '07/01/17 14:00', 'Surrey Athletic',         'Merrow A',                  'Bisley Recreation Ground',          'Division Two']
      expect(fixture[9]).to eq  ['Div2', '07/01/17 14:00', 'Wrecclesham',             'AFC Westend Reserves',      'Wrecclesham Recreation Ground',     'Division Two']
      expect(fixture[10]).to eq ['SLJC', '07/01/17 13:30', 'Perrywood Sports (Seniors) First', 'Hersham Vila',     '***To be confirmed by club***',     'Surrey County FA Lower Junior Cup']
      expect(fixture[11]).to eq ['Div2', '14/01/17 14:00', 'Farncombe Athletic',      'Surrey Athletic',           'Broadwater School',                 'Division Two']
      expect(fixture[12]).to eq ['Div2', '14/01/17 14:00', 'Hersham Vila',            'Wrecclesham',               "St. George's College",              'Division Two']
      expect(fixture[13]).to eq ['Div2', '14/01/17 14:00', 'Horsley A',               'AFC Westend Reserves',      "Tom's Field",                       'Division Two']
      expect(fixture[14]).to eq ['Div2', '14/01/17 14:00', 'Merrow A',                'Deepcut Community',         'Urnfield #1',                       'Division Two']
    end

    scenario 'Cup results with penalities and extra time' do
      fixture = described_class.new(Rails.root + 'spec/fixtures/cup_results.html').fixtures
      #                           Abbr        Date               Home                   Score     Away                        Competition
      expect(fixture[0]).to eq  ['IntC', '29/04/17 14:00', 'Staines Lammas Reserves',   '0 - 1', 'Pirbright',                 'Intermediate Cup']
      expect(fixture[1]).to eq  ['IntC', '01/04/17 13:30', 'Pirbright',                 '1 - 0', 'Burpham Reserves',          'Intermediate Cup']
      expect(fixture[2]).to eq  ['IntC', '01/04/17 13:30', 'Staines Lammas Reserves',   '2 - 1', 'Laleham Athletic',          'Intermediate Cup']
      expect(fixture[3]).to eq  ['IntC', '18/03/17 13:30', 'Laleham Reserves',          '1 - 3', 'Staines Lammas Reserves',   'Intermediate Cup']
      expect(fixture[4]).to eq  ['IntC', '18/03/17 13:30', 'Pirbright',                 '4 - 1', 'Wrecclesham',               'Intermediate Cup']
      expect(fixture[5]).to eq  ['IntC', '11/03/17 13:30', 'Laleham Athletic',          '1 - 0', 'AFC Westend Reserves',      'Intermediate Cup']
      expect(fixture[6]).to eq  ['IntC', '11/03/17 13:30', 'Worplesdon Phoenix A',      '3 - 5', 'Burpham Reserves',          'Intermediate Cup']
      expect(fixture[7]).to eq  ['IntC', '04/02/17 13:30', 'Staines Lammas Reserves',   '3 - 1', 'Windlesham & Lightwater A', 'Intermediate Cup']
      expect(fixture[8]).to eq  ['IntC', '28/01/17 13:30', 'Deepcut Community',         '5 - 7', 'Wrecclesham',               'Intermediate Cup']
      expect(fixture[9]).to eq  ['IntC', '28/01/17 13:30', 'Horsley A',                 '2 - 6', 'AFC Westend Reserves',      'Intermediate Cup']
      expect(fixture[10]).to eq ['IntC', '28/01/17 13:30', 'Laleham Athletic',          '9 - 1', 'Surrey Athletic',           'Intermediate Cup']
      expect(fixture[11]).to eq ['IntC', '28/01/17 13:30', 'Laleham Reserves',          '3 - 2', 'Byfleet',                   'Intermediate Cup']
      expect(fixture[12]).to eq ['IntC', '17/12/16 13:30', 'Burpham Reserves',          '3 - 0', 'Merrow A',                  'Intermediate Cup']
      expect(fixture[13]).to eq ['IntC', '17/12/16 13:30', 'Pirbright',                 '3 - 3', 'Woking & Maybury',          'Intermediate Cup']
      expect(fixture[14]).to eq ['IntC', '10/12/16 13:30', 'Dunsfold',                  '2 - 2', 'Laleham Reserves',          'Intermediate Cup']
      expect(fixture[15]).to eq ['IntC', '10/12/16 13:30', 'Horsley A',                 '3 - 0', 'FC Staines',                'Intermediate Cup']
      expect(fixture[16]).to eq ['IntC', '10/12/16 13:30', 'Windlesham & Lightwater A', 'H - W', 'Virginia Water A',          'Intermediate Cup', 'Home Walkover ']
      expect(fixture[17]).to eq ['IntC', '10/12/16 13:30', 'Woking Tigers',             'A - W', 'Deepcut Community',         'Intermediate Cup', 'Away Walkover ']
    end
  end
end
