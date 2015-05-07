require 'rails_helper'
require 'spec_helper'

describe "Premium user" do
  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    @user = create(:premium_user)
    login_as(@user, :scope => :user)
  end

  context "wants to add a collaborator" do
    it "can add a collaborator from the edit page of one of its wikis" do
      wiki = create(:private_wiki, :user_id => @user.id)
      collaborator = create(:user, )
      visit edit_wiki_path(wiki)
      #select collaborator.id
    end
  end
end
