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
      fill_in 'competition_cup[abbreviation]', with: '2017'
      fill_in 'competition_cup[year]', with: 'Cup'
      fill_in 'competition_cup[fixture_url]', with: 'www.test.com/fixtures'
      fill_in 'competition_cup[result_url]', with: 'www.test.com/results'
      check 'First Team'
      expect { click_button 'Create Cup' }.to change(described_class, :count).from(0).to(1)
      expect(page).to have_css '.alert-success', text: 'Cup successfully created'
    end

    it 'Will not allow you to create an invalid cup' do
      visit cups_path
      click_link 'Add a Cup'
      expect { click_button 'Create Cup' }.not_to change(described_class, :count)
      expect(page).to have_css '.alert.alert-warning', text: "Failed to create cup, Name can't be blank, Year can't be blank, Result url can't be blank"
    end
  end

  context 'with existing cups' do
    let!(:cup) { FactoryBot.create :cup }
    let!(:fixture) { create :fixture, date: (Date.today + 1.week), competition: cup }
    let!(:result) { create :fixture, date: (Date.today - 1.week), competition: cup, home_score: '1', away_score: '0' }

    it 'Will show the fixtures of the cup' do
      visit cup_fixtures_path(cup)
      expect(page).to have_css 'h2', text: cup.name
      expect(page).to have_fixture(fixture)
      expect(page).to have_result(result)
    end

    context '#edit' do
      it 'will allow you to edit a cup' do
        visit cups_path
        click_link 'Edit'
        fill_in 'competition_cup[name]', with: 'Edited Cup'
        fill_in 'competition_cup[year]', with: '2020'
        click_button 'Update Cup'
        expect(page).to have_css '.alert-success', text: 'Cup successfully updated'
        expect(page).to have_css 'a', text: 'Edited Cup'
        expect(page).to have_css 'td', text: 2020
      end

      it 'will not allow you to make invalid cup' do
        visit cups_path
        click_link 'Edit'
        fill_in 'competition_cup[name]', with: ''
        fill_in 'competition_cup[abbreviation]', with: ''
        fill_in 'competition_cup[year]', with: ''
        fill_in 'competition_cup[result_url]', with: ''
        click_button 'Update Cup'
        expect(page).to have_css '.alert.alert-warning', text: "Failed to update, Name can't be blank, Year can't be blank, Result url can't be blank"
      end

      context 'inactive' do
        let!(:cup) { FactoryBot.create :cup, active: false }
        it 'will allow you to change the activity of a cup', js: true do
          visit cups_path
          find('label[data-active="1"]').click
          expect(page).to have_css '.alert-success', text: 'Cup updated successfully'
        end
      end
    end
  end
end
