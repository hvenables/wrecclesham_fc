# frozen_string_literal: true

require 'rails_helper'

describe User do
  it 'will see the sign in links and not sign out' do
    visit root_path
    expect(page).to have_link 'Log in'
    expect(page).to have_link 'Sign up'
    expect(page).not_to have_link 'Sign out'
  end

  context 'when signed in' do
    let(:user) { create :user }

    it 'will see the sign out link' do
      sign_in(user)
      expect(page).not_to have_link 'Log in'
      expect(page).not_to have_link 'Sign up'
      expect(page).to have_link 'Sign out'
    end
  end
end
