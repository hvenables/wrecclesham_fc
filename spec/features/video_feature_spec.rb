require 'rails_helper'

feature 'video' do
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
        expect(page).to have_content video.summary
        expect(page).to have_css("img[src*='#{video.thumbnail}']")
      end
    end
  end

  context '#show' do
    let!(:video) { create :video}
    scenario 'Should be able to visit a individual video' do
      visit video_path(video)
      expect(page).to have_content video.title
      expect(page).to have_content video.summary
      expect(page).to have_css("iframe[src*='#{video.url_santizer}']")
    end
  end

  context '#new/#create' do
    before(:example) do
      stub_yt
    end
    scenario 'should be able to add a video' do
      sign_in(admin)
      click_link 'New video'
      fill_in 'Title', with: "Test Video"
      fill_in 'Summary', with: 'Test Summary'
      fill_in 'basic-url', with: 'https://www.youtube.com/embed/2iOQ053s_oM'
      click_button 'Create Video'
      expect(page).to have_content 'Test Video'
      expect(page).to have_content 'Test Summary'
      expect(page).to have_css("iframe[src*='//www.youtube.com/embed/2iOQ053s_oM']")
    end
  end

  context '#edit/#update' do
    let(:video) { create :video }
    before(:example) do
      stub_yt
    end
    scenario 'should be able to edit a video' do
      sign_in(admin)
      visit video_path(video)
      click_link 'Edit'
      fill_in 'Title', with: "Test Video"
      fill_in 'Summary', with: 'Test Summary'
      fill_in 'basic-url', with: 'https://www.youtube.com/embed/2iOQ053s_oM'
      click_button 'Update Video'
      expect(page).to have_content 'Test Video'
      expect(page).to have_content 'Test Summary'
      expect(page).to have_css("iframe[src*='//www.youtube.com/embed/2iOQ053s_oM']")
    end
  end

  context '#destroy' do
    let(:video) { create :video }
    before(:example) do
      stub_yt
    end
    scenario 'should be able to delete a video' do
      sign_in(admin)
      visit video_path(video)
      click_link 'Delete'
      expect(current_path).to eq videos_path
      expect(page).to_not have_content 'Video Title'
      expect(page).to_not have_content 'Video Summary'
      expect(page).to have_content 'Video has been deleted'
    end
  end
end
