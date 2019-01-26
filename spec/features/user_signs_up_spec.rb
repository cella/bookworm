require 'rails_helper'

RSpec.feature "User signs up" do
  scenario "successfully" do
    visit "/"
    click_link "Sign up"
    expect(page).to have_current_path("/users/sign_up")

    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "test123"
    fill_in "Password confirmation", with: "test123"

    click_button "Sign up"

    expect(page).to have_current_path("/")
    expect(page).to have_content "Welcome! You have signed up successfully"
  end

  scenario "unsuccessfully" do
    visit "/"
    click_link "Sign up"
    expect(page).to have_current_path("/users/sign_up")

    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"

    click_button "Sign up"

    expect(page).to have_current_path("/users")
    expect(page).to have_css("#error_explanation")
  end
end
