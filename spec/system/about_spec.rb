# frozen_string_literal: true

require 'rails_helper'

describe About do
  let(:admin) { FactoryBot.create :admin }

  context 'when no about exists' do
    it 'will prompt display no about and only display button to admin' do
      visit root_path
      click_link 'About'
      expect(page).to have_content 'No current About section'
      expect(page).not_to have_link 'Create About'
    end

    it 'should display add news if admin' do
      sign_in(admin)
      visit about_path
      expect(page).to have_link 'Create About'
    end
  end

  context 'when Admin signed in' do
    before { sign_in(admin) }

    it 'will be able to add about' do
      visit about_path
      click_link 'Create About'
      fill_in 'about[content]', with: 'Test About'
      click_button 'Create About'
      expect(page).to have_css 'p', text: 'Test About'
      expect(page).to have_css '.alert-success', text: 'About successfully created'
      expect(page).to have_current_path about_path
    end

    it 'will not allow invalid about' do
      visit about_path
      click_link 'Create About'
      fill_in 'about[content]', with: ''
      click_button 'Create About'
      expect(page).to have_css '.alert-warning', text: "About failed to save, Content can't be blank"
    end

    context 'when about already exists' do
      let!(:about) { FactoryBot.create :about }

      it 'will show the about' do
        visit about_path
        expect(page).to have_css 'p', text: about.content
      end

      it 'will allow admin to edit about' do
        visit about_path
        click_link 'Edit About'
        fill_in 'about[content]', with: 'New About'
        click_button 'Update About'
        expect(page).to have_css 'p', text: 'New About'
        expect(page).to have_css '.alert-success', text: 'About successfully updated'
      end

      it 'wont allow you to update about to invalid state' do
        visit about_path
        click_link 'Edit About'
        fill_in 'about[content]', with: ''
        click_button 'Update About'
        expect(page).to have_css '.alert-warning', text: "About failed to save, Content can't be blank"
      end
    end
  end
end
