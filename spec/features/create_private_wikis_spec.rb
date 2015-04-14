require 'rails_helper'
require 'spec_helper'
require 'pry'

feature "Premium user creates a private wiki" do

  include Warden::Test::Helpers
  Warden.test_mode!
  context "a logged in user with role of free" do
    before do
      @user = create(:user)
      login_as(@user, :scope => :user)
    end

    it 'cannot create private wikis' do
      visit root_path
      click_link "Create wiki"

      expect(page).to_not have_content("Private")
    end
  end

  context "a logged in user with role of premium" do

    before do
      @user = create(:user, :role => 'premium')
      login_as(@user, :scope => :user)
    end

    it "can create a private wiki" do
      visit root_path
      click_link "Create wiki"
      fill_in 'wiki[title]', with: 'Private Wiki title'
      fill_in 'wiki[body]', with: 'Wiki body'
      check "wiki[private]"
      click_button "Save"

      expect(Wiki.first.private).to be(true)
    end

  end

  context "a logged in user with role of admin" do

    before do
      @user = create(:user, :role => 'admin')
      login_as(@user, :scope => :user)
    end

    it "can create a private wiki" do
      visit root_path
      click_link "Create wiki"
      fill_in 'wiki[title]', with: 'Private Wiki title'
      fill_in 'wiki[body]', with: 'Wiki body'
      check "wiki[private]"
      click_button "Save"

      expect(Wiki.first.private).to be(true)
    end

  end
end
