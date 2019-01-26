require 'rails_helper'

RSpec.feature "User signs up" do

  def sign_up(email, password, password_confirm=password)
    visit "/"
    click_link "Sign up"
    expect(page).to have_current_path("/users/sign_up")

    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "Password confirmation", with: password_confirm

    click_button "Sign up"
  end

  scenario "successfully" do
    sign_up('test@test.com', 'password')

    expect(page).to have_current_path("/")
    expect(page).to have_content "Welcome! You have signed up successfully"
  end

  context "with a mismatched password confirmation" do
    scenario "sees error" do
      sign_up('test@test.com', 'password', 'passwerd')

      expect(page).to have_current_path("/users")
      expect(page).to have_css("#error_explanation")
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end

  context "with too short of a password" do
    scenario "sees error" do
      sign_up('test@test.com', 'test')

      expect(page).to have_current_path("/users")
      expect(page).to have_css("#error_explanation")
      expect(page).to have_content("Password is too short")
    end
  end
end
