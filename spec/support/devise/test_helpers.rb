
# frozen_string_literal: true

module DeviseTestHelpers
  def sign_up(user)
    visit root_path
    click_link('Sign up')
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    fill_in :user_password_confirmation, with: user.password
    click_button 'Sign up'
  end

  def sign_in(user)
    visit root_path
    click_link('Log in')
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    click_button 'Log in'
  end
end
