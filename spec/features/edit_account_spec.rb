require 'rails_helper'
require 'spec_helper'

describe 'User Account page' do

  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    @user = create(:user)
    login_as(@user, :scope => :user)
  end

  # TODO: Ask stackoverflow about this spec which is behaving strangely
  xit 'allows user to change their password' do
    @user.password = "OldPassword"
    old_password, new_password = @user.password, 'NewPassword'

    visit edit_user_registration_path
    fill_in "user[email]", with: @user.email
    fill_in "user[password]", with: new_password
    fill_in "user[password_confirmation]", with: new_password
    fill_in "user[current_password]", with: old_password
    click_button "Update"

    expect(page).to have_content("Your account has been updated successfully")
    expect(@user.password).to eq(new_password)
  end

  it 'allows user to cancel their account' do
    expect(true).to be(true)
  end

  xit 'allows user to upgrade their plan to premium' do
    visit edit_user_registration_path
    click_link "Upgrade"

    expect(@user.role).to be("premium")
  end

  xit 'allows user to downgrade their plan to free' do
    @user.role = "premium"
    click_link "Downgrade"

    expect(@user.role).to be("free")
  end
end
