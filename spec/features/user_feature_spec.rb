require 'rails_helper'

feature 'user' do
  scenario 'should see the sign in links and not sign out' do
    visit root_path
    expect(page).to have_link 'Log in'
    expect(page).to have_link 'Sign up'
    expect(page).to_not have_link 'Sign out'
  end

  context 'Signed in' do
    let(:user) { create :user }
    scenario 'should see sign out links when signed in' do
      sign_in(user)
      expect(page).to_not have_link 'Log in'
      expect(page).to_not have_link 'Sign up'
      expect(page).to have_link 'Sign out'
    end
  end
end
