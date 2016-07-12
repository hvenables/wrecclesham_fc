require 'rails_helper'

feature 'video' do
  let(:admin) { create :admin }
  context '#index' do
    scenario 'should display that their is no videos' do
      visit root_path
      click_link 'Videos'
      expect(page).to have_content 'No videos have been added'
      expect(page).to_not have_link 'Add Video'
    end
  end

  context '#new' do
    scenario 'should be able to add a video' do
      sign_in(admin)
      click_link 'New video'
      fill_in 'Title', with: "Test Video"
      fill_in 'Summary', with: 'Test Summary'
      fill_in 'Url', with: 'www.test.com'
      click_button 'Create Video'
      expect(page).to have_content 'Test Video'
      expect(page).to have_content 'Test Summary'
      expect(page).to have_css 'iframe'
    end
  end
end
