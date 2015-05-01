require 'rails_helper'
require 'spec_helper'
require 'pry'

describe "Premium user" do

  include Warden::Test::Helpers
  Warden.test_mode!

  context "when logged in" do
    before do
      @user = create(:user, :role => 'premium')
      login_as(@user, :scope => :user)
    end

    it "can create a private wiki" do
      visit wikis_path
      click_link "Create wiki"
      fill_in 'wiki[title]', with: 'Private Wiki title'
      fill_in 'wiki[body]', with: 'Wiki body'
      check "wiki[private]"
      click_button "Save"

      expect(Wiki.first.private).to be(true)
    end

    it "can view private wikis they have created" do
      create(:wiki, :private  => true, :user_id => @user.id)
      visit root_path

      expect(page).to have_content("Wiki title")
    end

    it "can downgrade plan to free " do
      visit edit_user_registration_path
      #expect(page).to have_content("Downgrade to Free")
      #click_link "Downgrade to Free"

      #expect(@user.role).to eq("free")
    end

    it 'can add a standard user as a collaborator to a private wiki' do
      create(:private_wiki, :user_id => @user.id)

      visit wikis_path
      click_link 'edit'
      click_link 'Add Collaborator'

      expect()
    end

    xit "will see all the private posts that will become public upon downgrading" do

    end

    xit "can choose to delete all private posts when downgrading plan" do

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

    context "a user with private wikis downgrades their account" do
      before do
        @user = create(:user, :role => 'admin')
      end
    end
  end
end
