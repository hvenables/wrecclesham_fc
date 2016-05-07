require 'rails_helper'

feature 'news' do
  context 'no news has been added' do
    let(:admin) { create :admin }

    scenario 'should display that their is no news' do
      visit root_path
      click_link 'News'
      expect(page).to have_css "div.news", text: 'No news has been add yet'
      expect(page).to_not have_link 'Add News'
    end

    scenario 'should display add news if admin' do
      sign_in(admin)
      click_link 'News'
      expect(page).to have_css "div.news", text: 'No news has been add yet'
      expect(page).to have_link 'Add news'
    end
  end
end
