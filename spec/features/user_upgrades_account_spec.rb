require 'rails_helper'
require 'spec_helper'
require 'pry'

describe "User" do

  include Warden::Test::Helpers
  Warden.test_mode!

  it "can sign up for a premium account by creating a new subscription" do
    user = create(:user)
    login_as(user, :scope => :user)

    visit edit_user_registration_path
    click_button "Upgrade"

    # TODO: This actually seems kind of complicated to test if I'm using the javascript code provided by stripe
    # In order to fill out the form I'll need to read up about testing javascript with capybara. Not a topic for right now.
    # That or we could just figure out how to make sure that we've called that script

    expect(User.first.role).to eq("premium")
    expect(Subscription.count).to eq(1)
    expect(Subscription.first.customer_id).to_not be_nil

    # TODO: And we expect their credit card to have been charged--we'll probably have to use mocks to ensure that the stripe API has been hit.
  end

  it "can cancel their subscription and downgrade to free" do
    user = create(:user, :role => "premium")
    subscription = create(:subscription, :user_id => user.id)
    login_as(user, :scope => :user)

    visit edit_user_registration_path
    click_link "Downgrade to Free"

    expect(User.first.role).to eq("free")
    expect(Subscription.count).to eq(0)
    # TODO: This seems easier to test--we can just make sure that the Subscription object has been deleted and the user has no subscription.
    # Then we test the rake task to makes sure that it won't charge anyone who doesn't have a subscription. We don't need to test that here.
    # (Confirm with someone credible as to whether your intuition about this is correct)
  end
end
