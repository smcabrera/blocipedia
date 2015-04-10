# As a user, I want to be able to sign up for a new account
require 'spec_helper'
require 'rails_helper'
require 'spec_helper'

feature 'New user signs up' do
  scenario 'with invalid username and password' do
    visit root_path
    click_link "Sign up"
    fill_in 'user_email', with: 'noatsign'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'

    expect(User.all.count).to eq(0)
  end

  scenario 'with valid username and password' do
    visit root_path
    click_link "Sign up"

    fill_in 'user_email', with: 'userA@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'

    click_button 'Sign up'

    expect(User.all.count).to eq(1)
  end
end

feature 'User sign in' do
  scenario 'user supplies valid credentials' do
    User.create(
    :email => 'username@example.com',
    :password => 'password'
    )

    visit root_path
    click_link "Sign in"
    fill_in 'user_email', with: 'username@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'

    expect(page).to have_content('Sign out')
  end

  scenario 'user supplies invalid credentials' do
    visit root_path
    click_link "Sign in"
    fill_in 'user_email', with: 'invalid@bogus.com'
    fill_in 'user_password', with: 'WrongPassword'
    click_button 'Log in'

    expect(page).to have_content("Log in")
  end
end

feature 'User sign out' do
  scenario 'user signs in and then signs out' do
    User.create(
      :email => 'userC@example.com',
      :password => 'password'
    )

    visit root_path
    click_link "Sign in"
    fill_in 'user_email', with: 'userC@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'
    click_link "Sign out"

    expect(page).to have_content('Sign in')
  end
end
