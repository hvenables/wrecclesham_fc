# frozen_string_literal: true

require 'rails_helper'

describe Competition::Cup do
  let(:admin) { create :admin }
  let!(:first_team) { create :team, name: 'Wrecclesham' }
  let!(:reserve_team) { create :team, name: 'Wrecclesham Reserves' }

  before(:each) do
    sign_in(admin)
  end

  context 'with no existing cups' do
    it 'will prompt to add a cup' do
      visit cups_path
      expect(page).to have_css 'p', text: 'Please Add a Cup'
      expect(page).to have_link 'Add a Cup'
    end

    it 'will allow you to create a cup' do
      visit cups_path
      click_link 'Add a Cup'
      fill_in 'competition_cup[name]', with: 'Test Cup'
      fill_in 'competition_cup[abbreviation]', with: 'Cup'
      fill_in 'competition_cup[year]', with: 'Cup'
      fill_in 'competition_cup[fixture_url]', with: 'www.test.com/fixtures'
      fill_in 'competition_cup[result_url]', with: 'www.test.com/results'
      choose 'First Team'
      expect { click_button 'Create Cup' }.to change { described_class.count }.from(0).to(1)
      expect(page).to have_css '.alert-success', text: 'Cup successfully created'
    end
  end
end
