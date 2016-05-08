require 'rails_helper'

feature 'news' do
  let(:admin) { create :admin }
  context 'no news has been added' do

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

  context 'Adding a new news story' do
    scenario 'prompts admin to fill in a form' do
      sign_in(admin)
      click_link 'News'
      click_link 'Add news'
      fill_in 'Title', with: 'Test Article'
      fill_in 'Content', with: 'Test Content'
      click_button 'Create News Story'
      expect(current_path).to eq news_index_path
      expect(page).to have_content 'Test Article'
      expect(page).to have_content 'Test Content'
      expect(page).to have_content "News story successfully published"
    end
  end
  
  context "Editing an existing news story" do

  end
end
