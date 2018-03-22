require 'rails_helper'

RSpec.describe 'Recent Form' do
  let(:json_response) { JSON.parse(response.body) }

  let!(:team) { create :team, name: 'Wrecclesham' }
  let!(:league) { create :league_table, active: true }
  let!(:season) { create :season, team: team, league_table: league }

  before do
    team.competitions << league
  end

  context '#show' do
    it 'Will return current seasons data' do
      get charts_recent_form_path(team_id: team.id)

      expect(json_response['datasets'][0]['data']).to eq [2, 2, 2]
      expect(json_response['datasets'][0]['background_color']).to eq ['#28a745', '#007bff', '#dc3545']
      expect(json_response['datasets'][0]['hover_background_color']).to eq ['#28a745', '#007bff', '#dc3545']
    end
  end
end
