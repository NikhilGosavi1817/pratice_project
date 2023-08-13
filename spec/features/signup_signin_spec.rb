require 'rails_helper'

RSpec.describe User, type: :feature do
  let(:user) {build(:user)}

  it "first name is blank" do
    user=build(:user)
    user.password_confirmation = user.password
    visit new_user_registration_path
    fill_in 'First name', with: user.first_name
    fill_in 'Last name', with: user.last_name
    fill_in 'Age', with: user.age
    fill_in 'Date of birth', with: user.date_of_birth
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation
    click_button "Sign up"
    expect(page).to have_content("Welcome! You have signed up successfully.")
  end
end
