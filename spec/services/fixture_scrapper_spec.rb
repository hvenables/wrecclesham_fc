# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FixtureScrapper do
  context 'Fixtures' do
    scenario 'Will return an array of fixtures' do
      fixture = FixtureScrapper.new(Rails.root + 'spec/fixtures/test_fixtures.html').fixtures
      #                             Date                   Home                       Away                             Venue                   Competition
      expect(fixture[0]).to eq  ['24/03/18 14:00', 'Deepcut Community',       'West Byfleet Albion',     'Deepcut Community Football Club',   'Division 1']
      expect(fixture[1]).to eq  ['24/03/18 14:00', 'Elstead',                 'Chertsey Old Salesians',  'Thursley Recreation Ground',        'Division 1']
      expect(fixture[2]).to eq  ['24/03/18 14:00', 'Hammer United',           'Woking Tigers',           'Haslemere Rec',                     'Division 1']
      expect(fixture[3]).to eq  ['24/03/18 14:00', 'Woking & Maybury',        'Abbey Rangers A',         'Wheatsheaf Common',                 'Division 1']
      expect(fixture[4]).to eq  ['31/03/18 14:00', 'Deepcut Community',       'Hammer United',           'Deepcut Community Football Club',   'Division 1']
      expect(fixture[5]).to eq  ['31/03/18 14:00', 'Woking & Maybury',        'Elstead',                 'Wheatsheaf Common',                 'Division 1']
      expect(fixture[6]).to eq  ['31/03/18 14:00', 'Wrecclesham',             'Staines Lammas Reserves', 'Wrecclesham Recreation Ground',     'Division 1']
      expect(fixture[7]).to eq  ['07/04/18 14:00', 'Chertsey Old Salesians',  'Abbey Rangers A',         'Victory Park',                      'Division 1']
      expect(fixture[8]).to eq  ['07/04/18 14:00', 'Deepcut Community',       'Woking Tigers',           'Deepcut Community Football Club',   'Division 1']
      expect(fixture[9]).to eq  ['14/04/18 14:00', 'Woking & Maybury',        'Wrecclesham',             'Wheatsheaf Common',                 'Division 1']
      expect(fixture[10]).to eq ['14/04/18 14:00', 'Woking Tigers',           'Chertsey Old Salesians',  'West Byfleet Recreation Ground #1', 'Division 1']
      expect(fixture[11]).to eq ['21/04/18 14:00', 'Chertsey Old Salesians',  'Deepcut Community',       'Victory Park',                      'Division 1']
      expect(fixture[12]).to eq ['21/04/18 14:00', 'Woking Tigers',           'Abbey Rangers A',         'West Byfleet Recreation Ground #1', 'Division 1']
      expect(fixture[13]).to eq ['28/04/18 14:00', 'Chertsey Old Salesians',  'Elstead',                 'Victory Park',                      'Division 1']
      expect(fixture[14]).to eq ['28/04/18 14:00', 'Staines Lammas Reserves', 'Woking Tigers',           'Littleton Recreation Ground',       'Division 1']
      expect(fixture[15]).to eq ['28/04/18 14:00', 'Wrecclesham',             'Abbey Rangers A',         'Wrecclesham Recreation Ground',     'Division 1']
      expect(fixture[16]).to eq ['05/05/18 14:00', 'Wrecclesham',             'Deepcut Community',       'Wrecclesham Recreation Ground',     'Division 1']
    end

    scenario 'Cup results with penalities and extra time' do
      fixture = described_class.new(Rails.root + 'spec/fixtures/cup_results.html').fixtures
      #                                Date               Home                   Score     Away                        Competition
      expect(fixture[0]).to eq  ['29/04/17 14:00', 'Staines Lammas Reserves',   '0 - 1', 'Pirbright',                 'Intermediate Cup']
      expect(fixture[1]).to eq  ['01/04/17 13:30', 'Pirbright',                 '1 - 0', 'Burpham Reserves',          'Intermediate Cup']
      expect(fixture[2]).to eq  ['01/04/17 13:30', 'Staines Lammas Reserves',   '2 - 1', 'Laleham Athletic',          'Intermediate Cup']
      expect(fixture[3]).to eq  ['18/03/17 13:30', 'Laleham Reserves',          '1 - 3', 'Staines Lammas Reserves',   'Intermediate Cup']
      expect(fixture[4]).to eq  ['18/03/17 13:30', 'Pirbright',                 '4 - 1', 'Wrecclesham',               'Intermediate Cup']
      expect(fixture[5]).to eq  ['11/03/17 13:30', 'Laleham Athletic',          '1 - 0', 'AFC Westend Reserves',      'Intermediate Cup']
      expect(fixture[6]).to eq  ['11/03/17 13:30', 'Worplesdon Phoenix A',      '3 - 5', 'Burpham Reserves',          'Intermediate Cup']
      expect(fixture[7]).to eq  ['04/02/17 13:30', 'Staines Lammas Reserves',   '3 - 1', 'Windlesham & Lightwater A', 'Intermediate Cup']
      expect(fixture[8]).to eq  ['28/01/17 13:30', 'Deepcut Community',         '5 - 7', 'Wrecclesham',               'Intermediate Cup']
      expect(fixture[9]).to eq  ['28/01/17 13:30', 'Horsley A',                 '2 - 6', 'AFC Westend Reserves',      'Intermediate Cup']
      expect(fixture[10]).to eq ['28/01/17 13:30', 'Laleham Athletic',          '9 - 1', 'Surrey Athletic',           'Intermediate Cup']
      expect(fixture[11]).to eq ['28/01/17 13:30', 'Laleham Reserves',          '3 - 2', 'Byfleet',                   'Intermediate Cup']
      expect(fixture[12]).to eq ['17/12/16 13:30', 'Burpham Reserves',          '3 - 0', 'Merrow A',                  'Intermediate Cup']
      expect(fixture[13]).to eq ['17/12/16 13:30', 'Pirbright',                 '3 - 3', 'Woking & Maybury',          'Intermediate Cup']
      expect(fixture[14]).to eq ['10/12/16 13:30', 'Dunsfold',                  '2 - 2', 'Laleham Reserves',          'Intermediate Cup']
      expect(fixture[15]).to eq ['10/12/16 13:30', 'Horsley A',                 '3 - 0', 'FC Staines',                'Intermediate Cup']
      expect(fixture[16]).to eq ['10/12/16 13:30', 'Windlesham & Lightwater A', 'H - W', 'Virginia Water A',          'Intermediate Cup', 'Home Walkover ']
      expect(fixture[17]).to eq ['10/12/16 13:30', 'Woking Tigers',             'A - W', 'Deepcut Community',         'Intermediate Cup', 'Away Walkover ']
    end
  end
end
