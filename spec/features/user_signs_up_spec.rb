require 'rails_helper'

RSpec.feature "User signs up" do
  scenario "successfully" do
    visit "/"
    click_link "Sign up"
    expect(page).to have_current_path("/users/sign_up")

    # next steps here / homework
    # - filling out sign up form
    # - submitting the sign up form
    # - expect success flash is present
    # - expect user is signed in
  end
end
