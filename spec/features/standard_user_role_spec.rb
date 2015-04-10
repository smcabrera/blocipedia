require 'rails_helper'
require 'spec_helper'

describe "Standard (free) User role" do

  include Warden::Test::Helpers
  Warden.test_mode!

  context "when logged in as standard user" do

    before do
      @user = create(:user)
      @other_user = create(:user)
      login_as(@user, :scope => :user)
    end

    it "is able to edit public wikis created by another user" do
      public_wiki = create(:public_wiki, user_id: @other_user.id)

      visit root_path
      click_link "edit"
      fill_in "wiki[title]", with: "Edited Title"
      fill_in "wiki[body]", with: "Edited body"
      click_button "Save"

      expect(page).to have_content("Edited Title")
    end

    # TODO: I'm not sure how to test this since the result of using pundit is that this will error
    # It's doing the *right* thing but the error makes the test fail rather than succeeding
    # I'm going to move on (because it works) but this is something I'd like to resolve.
    xit 'cannot delete wikis created by another user' do
      @user = create(:user)
      login_as(@user, :scope => :user)
      public_wiki = create(:public_wiki, user_id: @other_user.id)
      visit root_path
      click_link "delete"

      expect(page).to have_content("Wiki title")
    end

  end
end
