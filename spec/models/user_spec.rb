require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {build(:user)}

  it "first name is blank" do
    user.first_name=""
    expect(user).to_not be_valid
    expect(user.errors[:first_name]).to include("can't be blank")
  end
end
