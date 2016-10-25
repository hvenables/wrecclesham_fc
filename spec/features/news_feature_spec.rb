require 'rails_helper'

feature 'news' do
  let(:admin) { create :admin }
  context 'no news has been added' do

    scenario 'should display that their is no news' do
      visit root_path
      click_link 'News'
      expect(page).to have_content 'No News has been added yet'
      expect(page).to_not have_link 'Add News'
    end

    scenario 'should display add news if admin' do
      sign_in(admin)
      expect(page).to have_link 'New article'
    end
  end

  context 'Adding a new news story' do
    scenario 'prompts admin to fill in a form' do
      sign_in(admin)
      click_link 'New article'
      fill_in 'Title', with: 'Test Article'
      fill_in 'news[summary]', with: 'Test Summary'
      fill_in 'news[content]', with: 'Test Content'
      attach_file 'news[image]', File.join(Rails.root, 'spec', 'fixtures', 'test.png')
      click_button 'Create News'
      expect(page).to have_content 'Test Article'
      expect(page).to have_content 'Test Content'
      expect(page).to have_content "News story successfully published"
    end
  end

  context "Editing an existing news story" do
    let(:news) { create(:news) }
    scenario 'prompts user to fill in a form to edit story' do
      sign_in(admin)
      visit news_path(news)
      click_link "Edit"
      fill_in 'Title', with: 'Test Title'
      fill_in 'news[summary]', with: 'Test Summary'
      fill_in 'news[content]', with: 'Test Content'
      attach_file 'news[image]', File.join(Rails.root, 'spec', 'fixtures', 'test.png')
      click_button 'Update News'
      expect(page).to have_content 'Test Title'
      expect(page).to have_content 'Test Content'
      expect(page).to have_content "Succesfully updated the news article"
    end
  end
end
