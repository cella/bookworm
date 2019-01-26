require 'rails_helper'

RSpec.feature "User signs out" do
  scenario "successfully" do
    user = User.create(email: 'test@test.com', password: "password", password_confirmation: "password")
    visit "/"
    click_link "Sign in"
    expect(page).to have_current_path("/users/sign_in")

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"

    expect(page).to have_current_path("/")
    expect(page).to have_content "Signed in successfully"

    click_link "Log out"
    expect(page).to have_current_path("/")
    expect(page).to have_content "Signed out successfully"
  end
end
