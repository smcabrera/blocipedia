require 'rails_helper'
require 'spec_helper'

describe "Public wikis" do
  # See link below for testing devise with capybara
  # https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
  include Warden::Test::Helpers
  Warden.test_mode!

end
