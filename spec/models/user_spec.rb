require 'rails_helper'

RSpec.describe User, type: :model do

  it 'should default to standard (free) role' do
    user = create(:user)
    expect(user.role).to eq("free")
  end

  it "should be able to set a user's role to admin" do
    user = create(:user)
    user.role = "admin"
    expect(user.role).to eq("admin")
  end

  it "should be able to set a user's role to premium" do
    user = create(:user)
    user.role = "premium"
    expect(user.role).to eq("premium")
  end
end
