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
    #@user = User.new(:email => 'test@email.com', :password => 'password')
    #@user.skip_confirmation!
    #@user.save
    @user = create(:user)
    login_as(@user, :scope => :user)
  end

  it 'User who is not logged in cannot create wikis' do
    visit root_path
    click_link "Sign out"

    expect(page).to_not have_link('Create wiki')
  end

  it 'standard (free) user can create a public wiki' do

    visit root_path
    click_link "Create wiki"

    fill_in 'wiki[title]', with: 'Wiki title'
    fill_in 'wiki[body]', with: 'Wiki body'

    click_button "Save"

    expect(Wiki.all.count).to eq(1)
  end

  it 'Standard (free) user can view a public wiki' do
    Wiki.create(title: 'Public Wiki', body: "Wiki body")
    visit root_path

    click_link 'Public Wiki'

    expect(page).to have_content('Wiki body')
  end

  it 'Standard (free) user can edit a public wiki' do
    Wiki.create(title: 'Public Wiki', body: "Wiki body")

    visit root_path
    click_link 'edit'
    fill_in "wiki[title]", with: 'Updated title'
    click_button "Save"
    visit root_path

    expect(page).to have_content('Updated title')
  end

  it 'Standard (free) user can delete a public wiki' do
    Wiki.create(title: 'Public Wiki', body: "Wiki body")

    visit root_path
    click_link 'delete'

    expect(Wiki.all.count).to be(0)
  end
end
