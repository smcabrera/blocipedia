require 'rails_helper'
require 'spec_helper'

describe "Public wikis" do
  # See link below for testing devise with capybara
  # https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    # We need a logged in user for all of these
    # TODO: user could be extracted into a factory at some point to streamline these tests
    @user = User.create(:email => 'test@email.com', :password => 'password')
    login_as(@user, :scope => :user)
  end

  xit 'User who is not logged in cannot create wikis' do

  end

  it 'standard (free) user can create a public wiki' do

    visit root_path
    click_link "Create wiki"
    fill_in 'title', with: 'Wiki title'
    fill_in 'body', with: 'Wiki body'

    expect(Wiki.count.all).to eq(1)
  end

  xit 'Standard (free) user can view a public wiki' do
  end

  xit 'Standard (free) user can edit a public wiki' do
  end

  xit 'Standard (free) user can create a public wiki' do
  end
end
