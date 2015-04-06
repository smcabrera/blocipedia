require 'rails_helper'
require 'spec_helper'

describe 'New user sign up' do
  it 'user can sign up by supplying a user name and password' do
    visit root_path
    click_link "Sign up"

    expect(page).to have_content("Foo!")

    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 's3kr3t'
    fill_in 'user_password_confirmation', with: 's3kr3t'

    click_button 'Sign up'

    expect(page).to have_content('Hello')
  end
end

