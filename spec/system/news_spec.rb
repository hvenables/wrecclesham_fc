# frozen_string_literal: true

require 'rails_helper'

describe News do
  let(:admin) { create :admin }

  context 'when no news has been added' do
    it 'will display that their is no news' do
      visit root_path
      click_link 'News'
      expect(page).to have_content 'No News has been added yet'
      expect(page).not_to have_link 'Add News'
    end

    it 'will allow display add news if admin' do
      sign_in(admin)
      expect(page).to have_link 'New article'
    end
  end

  context 'when admin is signed in' do
    before do
      sign_in(admin)
    end

    context 'when adding a news story' do
      it 'will prompt the admin to fill in a form' do
        click_link 'New article'
        fill_in 'Title', with: 'Test Article'
        fill_in 'news[content]', with: 'Test Content'
        attach_file 'news[images_attributes][0][image]', File.join(Rails.root, 'spec', 'fixtures', 'test.png')
        click_button 'Create News'
        expect(page).to have_css 'h4.card-title',  text: 'Test Article'
        expect(page).to have_css 'p',              text: 'Test Content'
        expect(page).to have_css '.alert-success', text: 'News story successfully published'
        expect(page).to have_css 'img.headline-img'
      end

      it 'will not allow you to make an invalid news story' do
        click_link 'New article'
        fill_in 'Title', with: ''
        fill_in 'news[content]', with: ''
        click_button 'Create News'
        expect(page).to have_css(
          '.alert.alert-warning.flash-title',
          text: "News story failed to save, Title can't be blank, Content can't be blank, Images can't be blank"
        )
      end
    end

    context 'when editing a news story' do
      let(:news) { create(:news) }

      it 'will prompt the admin to fill in a form to edit story' do
        visit news_path(news)
        click_link 'Edit'
        fill_in 'Title', with: 'Test Title'
        fill_in 'news[content]', with: 'Test Content'
        attach_file 'news[images_attributes][0][image]', File.join(Rails.root, 'spec', 'fixtures', 'test.png')
        click_button 'Update News'
        expect(page).to have_css 'h4.card-title',  text: 'Test Title'
        expect(page).to have_css 'p',              text: 'Test Content'
        expect(page).to have_css '.alert-success', text: 'Succesfully updated the news article'
        expect(page).to have_css 'img.headline-img'
      end

      it 'will not allow an invalid new story' do
        visit news_path(news)
        click_link 'Edit'
        fill_in 'Title', with: ''
        fill_in 'news[content]', with: ''
        click_button 'Update News'
        expect(page).to have_css(
          '.alert.alert-warning.flash-title',
          text: "News story failed to update, Title can't be blank, Content can't be blank"
        )
      end
    end

    context 'when deleting a news story' do
      let(:news) { create(:news) }

      it 'will allow admin to delete the story' do
        visit news_path(news)
        click_link 'Delete'
        expect(page).to have_content 'News article has been deleted'
        expect(page).to have_current_path news_index_path
      end
    end
  end
end
