require 'rails_helper'

feature 'news' do
  context 'no news has been added' do
    scenario 'should display that their is no news' do
      visit root_path
      click_link 'News'
      expect(page).to have_css "div.news", text: 'No news has been add yet'
    end
  end
end
