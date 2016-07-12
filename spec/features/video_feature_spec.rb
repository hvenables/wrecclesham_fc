require 'rails_helper'

feature 'video' do
  scenario 'should display that their is no videos' do
    visit root_path
    click_link 'Videos'
    expect(page).to have_content 'No videos have been added'
    expect(page).to_not have_link 'Add Video'
  end
end
