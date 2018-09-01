# frozen_string_literal: true

require 'rails_helper'

describe Video do
  let(:admin) { create :admin }

  before do
    allow_any_instance_of(Yt::Video).to receive(:thumbnail_url).and_return('https://i.ytimg.com/vi/2iOQ053s_oM/mqdefault.jpg')
  end

  context 'when non admin user' do
    context 'when no videos have been added' do
      it 'will display that their is no videos' do
        visit root_path
        click_link 'Videos'
        expect(page).to have_content 'No videos have been added'
        expect(page).not_to have_link 'Add Video'
      end
    end

    context 'when videos have been added' do
      let!(:video) { create :video }

      it 'will display videos in a list' do
        visit root_path
        click_link 'Videos'
        expect(page).to have_content video.title
        expect(page).to have_content video.content
        expect(page).to have_css("img[src*='#{video.thumbnail}']")
      end

      it 'will be able to visit an individual video' do
        visit video_path(video)
        expect(page).to have_content video.title
        expect(page).to have_content video.content
        expect(page).to have_css("iframe[src*='#{video.url_santizer}']")
      end
    end
  end

  context 'when admin user signed in' do
    before do
      sign_in(admin)
    end

    context 'when no video exists' do
      before do
        stub_yt
      end

      it 'will allow you to add a new video' do
        click_link 'New video'
        fill_in 'Title', with: 'Test Video'
        fill_in 'Content', with: 'Test Summary'
        fill_in 'basic-url', with: 'https://www.youtube.com/embed/2iOQ053s_oM'
        click_button 'Create Video'
        expect(page).to have_content 'Test Video'
        expect(page).to have_content 'Test Summary'
        expect(page).to have_css("iframe[src*='//www.youtube.com/embed/2iOQ053s_oM']")
      end

      it 'will not allow you to make invalid video' do
        click_link 'New video'
        fill_in 'Title', with: ''
        fill_in 'Content', with: ''
        fill_in 'basic-url', with: ''
        click_button 'Create Video'
        expect(page).to have_css '.alert.alert-warning.flash-title', text: "Video failed to save, Title can't be blank, Content can't be blank, Url can't be blank"
      end
    end

    context 'when video has been added' do
      let(:video) { create :video }

      before do
        stub_yt
      end

      it 'will allow you to edit a video' do
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

      it 'will not allow you to invalidate a video' do
        visit video_path(video)
        click_link 'Edit'
        fill_in 'Title', with: ''
        fill_in 'Content', with: ''
        fill_in 'basic-url', with: ''
        click_button 'Update Video'
        expect(page).to have_css '.alert.alert-warning.flash-title', text: "Video failed to update, Title can't be blank, Content can't be blank, Url can't be blank"
      end

      it 'will allow you to delete a video' do
        visit video_path(video)
        click_link 'Delete'
        expect(page).not_to have_content 'Video Title'
        expect(page).not_to have_content 'Video Summary'
        expect(page).to have_content 'Video has been deleted'
        expect(page).to have_current_path videos_path
      end
    end
  end
end
