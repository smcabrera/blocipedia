require 'rails_helper'
require 'spec_helper'
require 'pry'

describe "Standard (free) User" do

  include Warden::Test::Helpers
  Warden.test_mode!

  context "when logged in" do

    before do
      @free_user = create(:user)
      @premium_user = create(:user, role: "premium")
      login_as(@free_user, :scope => :user)
    end

    it 'can create a public wiki' do

      visit root_path
      click_link "Create wiki"
      fill_in 'wiki[title]', with: 'Wiki title'
      fill_in 'wiki[body]', with: 'Wiki body'
      click_button "Save"

      expect(Wiki.all.count).to eq(1)
    end

    it 'can view a public wiki' do
      Wiki.create(title: 'Public Wiki', body: "Wiki body", user_id: @free_user.id)

      visit root_path
      click_link 'Public Wiki'

      expect(page).to have_content('Wiki body')
    end

    it 'can edit a public wiki they have published' do
      create(:public_wiki, :user_id => @free_user.id)

      visit root_path
      click_link 'edit'
      fill_in "wiki[title]", with: 'Updated title'
      click_button "Save"
      visit root_path

      expect(page).to have_content('Updated title')
    end

    it 'can delete their own public wiki' do
      create(:public_wiki, :user_id => @free_user.id)

      visit root_path
      click_link 'delete'

      expect(Wiki.all.count).to be(0)
    end

    it "can edit public wikis created by another user" do
      create(:public_wiki, user_id: @premium_user.id)

      visit root_path
      click_link "edit"
      # TODO: We can create a page object and combine filling in all the fields to a single step
      fill_in "wiki[title]", with: "Edited Title"
      fill_in "wiki[body]", with: "Edited body"
      click_button "Save"

      expect(page).to have_content("Edited Title")
    end

    it 'cannot delete wikis created by another user' do
    # I changed this to just test if the button is there
    # it actually doesn't make sense for a button to be visible to a user if they can't use it
      # I'll need to clean the test database first for this to work

      # Clean the test database
      public_wiki = create(:public_wiki, user_id: @premium_user.id)
      visit root_path

      expect(page).to_not have_content("delete")
    end

    it 'cannot view private wikis' do
      private_wiki = create(:private_wiki, user_id: @premium_user.id)
      visit root_path

      expect(page).to_not have_content("Private")
    end

    it 'cannot create private wikis' do
      private_wiki = create(:private_wiki, user_id: @premium_user.id)
      visit root_path
      click_link "Create wiki"

      expect(page).to_not have_content("private")
    end

  end

  context "when not logged in" do

    it 'cannot create wikis' do
      @free_user = create(:user)
      login_as(@free_user, :scope => :user)

      expect(page).to have_content('Hello')

      click_link "signout"

      visit root_path
      expect(page).to_not have_link('Create wiki')
    end
  end

end
