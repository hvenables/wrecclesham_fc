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

  context 'Need to be admin for spec' do
    before(:each) do
      sign_in(admin)
    end
    context 'Adding a new news story' do
      scenario 'prompts admin to fill in a form' do
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

      scenario 'Cant create an invalid news story' do
        click_link 'New article'
        fill_in 'Title', with: ''
        fill_in 'news[summary]', with: ''
        fill_in 'news[content]', with: ''
        click_button 'Create News'
        expect(page).to have_css '.alert.alert-warning.flash-title', text: "News story failed to save, Title can't be blank, Summary can't be blank, Image can't be blank, Content can't be blank"
      end
    end

    context "Editing an existing news story" do
      let(:news) { create(:news) }
      scenario 'prompts user to fill in a form to edit story' do
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

      scenario 'Cant change to an invalid news story' do
        visit news_path(news)
        click_link "Edit"
        fill_in 'Title', with: ''
        fill_in 'news[summary]', with: ''
        fill_in 'news[content]', with: ''
        click_button 'Update News'
        expect(page).to have_css '.alert.alert-warning.flash-title', text: "Failed to update, Title can't be blank, Summary can't be blank, Content can't be blank"
      end
    end

    context "Deleting an existing news story" do
      let(:news) { create(:news) }
      scenario 'can delete a news story' do
        visit news_path(news)
        click_link "Delete"
        expect(current_path).to eq news_index_path
        expect(page).to have_content "News article has been deleted"
      end
    end
  end
end
