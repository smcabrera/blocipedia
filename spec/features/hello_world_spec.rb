require 'spec_helper'

describe 'landing on the welcome page' do
  it 'displays hello' do
    visit root_path
    expect(page).to have_content('Hello World')
  end
end
