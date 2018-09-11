# frozen_string_literal: true

require 'rails_helper'

describe Season do
  let(:admin) { create :admin }
  let!(:team) { create :team, name: 'Wrecclesham' }
  let!(:league) { create :league_table, active: true }
  let(:table_data) do
    { 'Wrecclesham' => %W[1 18 3 3 3 31 20 3 3 3 31 20 6 6 6 52 40 #{''} 24] }
  end

  before do
    sign_in(admin)
    team.competitions << league

    expect(LeagueTableScrapper)
      .to receive(:seasons)
      .with(league.url)
      .and_return(table_data)
  end

  context 'when no seasons exist' do
    it 'Will allow you to create seasons' do
      visit root_path
      click_link 'League Tables'
      click_link 'First Team'
      click_link 'Add Teams'
      expect(page).to have_css '.alert.alert-success', text: 'League Tables seasons created'
      expect(page).to have_css 'td', text: '1'
      expect(page).to have_css 'td', text: 'Wrecclesham'
      expect(page).to have_css 'td', text: '18'
      expect(page).to have_css 'td', text: '6', count: 3
      expect(page).to have_css 'td', text: '12'
      expect(page).to have_css 'td', text: '24'
    end
  end

  context 'when a season exists' do
    let!(:season) { FactoryBot.create :season, league_table: league, team: team }

    it 'Will update existing seasons' do
      visit root_path
      click_link 'League Tables'
      click_link 'First Team'
      click_link 'Update Table'
      expect(page).to have_css '.alert.alert-success', text: 'League Table has been updated'
      expect(page).to have_css 'td', text: '1'
      expect(page).to have_css 'td', text: 'Wrecclesham'
      expect(page).to have_css 'td', text: '18'
      expect(page).to have_css 'td', text: '6', count: 3
      expect(page).to have_css 'td', text: '12'
      expect(page).to have_css 'td', text: '24'
    end
  end
end
