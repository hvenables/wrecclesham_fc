# frozen_string_literal: true

require 'rails_helper'

feature 'video' do
  before(:each) do
    allow_any_instance_of(Yt::Video).to receive(:thumbnail_url).and_return('https://i.ytimg.com/vi/2iOQ053s_oM/mqdefault.jpg')
  end
  let(:admin) { create :admin }
  context '#index' do
    context 'No Videos have been added' do
      scenario 'should display that their is no videos' do
        visit root_path
        click_link 'Videos'
        expect(page).to have_content 'No videos have been added'
        expect(page).to_not have_link 'Add Video'
      end
    end

    context 'Videos have been added' do
      let!(:video) { create :video }
      scenario 'should display videos in a list' do
        visit root_path
        click_link 'Videos'
        expect(page).to have_content video.title
        expect(page).to have_content video.content
        expect(page).to have_css("img[src*='#{video.thumbnail}']")
      end
    end
  end

  context '#show' do
    let!(:video) { create :video }
    scenario 'Should be able to visit a individual video' do
      visit video_path(video)
      expect(page).to have_content video.title
      expect(page).to have_content video.content
      expect(page).to have_css("iframe[src*='#{video.url_santizer}']")
    end
  end

  context 'Specs you need to be admin for' do
    before(:each) do
      sign_in(admin)
    end
    context '#new/#create' do
      before(:example) do
        stub_yt
      end
      scenario 'should be able to add a video' do
        click_link 'New video'
        fill_in 'Title', with: 'Test Video'
        fill_in 'Content', with: 'Test Summary'
        fill_in 'basic-url', with: 'https://www.youtube.com/embed/2iOQ053s_oM'
        click_button 'Create Video'
        expect(page).to have_content 'Test Video'
        expect(page).to have_content 'Test Summary'
        expect(page).to have_css("iframe[src*='//www.youtube.com/embed/2iOQ053s_oM']")
      end

      scenario 'not be able to add a video' do
        click_link 'New video'
        fill_in 'Title', with: ''
        fill_in 'Content', with: ''
        fill_in 'basic-url', with: ''
        click_button 'Create Video'
        expect(page).to have_css '.alert.alert-warning.flash-title', text: "Video failed to save, Title can't be blank, Content can't be blank, Url can't be blank"
      end
    end

    context '#edit/#update' do
      let(:video) { create :video }
      before(:example) do
        stub_yt
      end
      scenario 'should be able to edit a video' do
        visit video_path(video)
        click_link 'Edit'
        fill_in 'Title', with: 'Test Video'
        fill_in 'Content', with: 'Test Summary'
        fill_in 'basic-url', with: 'https://www.youtube.com/embed/2iOQ053s_oM'
        click_button 'Update Video'
        expect(page).to have_content 'Test Video'
        expect(page).to have_content 'Test Summary'
        expect(page).to have_css("iframe[src*='//www.youtube.com/embed/2iOQ053s_oM']")
      end

      scenario 'cant edit a video and make it invalid' do
        visit video_path(video)
        click_link 'Edit'
        fill_in 'Title', with: ''
        fill_in 'Content', with: ''
        fill_in 'basic-url', with: ''
        click_button 'Update Video'
        expect(page).to have_css '.alert.alert-warning.flash-title', text: "Video failed to update, Title can't be blank, Content can't be blank, Url can't be blank"
      end
    end

    context '#destroy' do
      let!(:video) { create :video }
      before(:example) do
        stub_yt
      end
      scenario 'should be able to delete a video' do
        visit video_path(video)
        click_link 'Delete'
        expect(current_path).to eq videos_path
        expect(page).to_not have_content 'Video Title'
        expect(page).to_not have_content 'Video Summary'
        expect(page).to have_content 'Video has been deleted'
      end
    end
  end
end
