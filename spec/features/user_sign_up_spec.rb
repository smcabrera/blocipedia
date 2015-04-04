# As a user, I want to be able to sign up for a new account
require 'spec_helper'

describe 'sign up page' do
  it 'allows me to sign up for a new account' do
    visit root_path

    click_link 'Sign up'

    fill_in 'email', with: 'email@example.com'
    fill_in 'password', with: 's3kr3t'
    click_button 'Save'

    expect(User.all.count).to be(1)
  end
end
