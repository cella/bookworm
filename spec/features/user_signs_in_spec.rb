require 'rails_helper'

RSpec.feature "User signs in" do
  let(:user) { create(:user) }

  scenario "successfully" do
    sign_in(user.email, user.password)

    expect(page).to have_current_path("/")
    expect(page).to have_content "Signed in successfully"
  end

  scenario "unsuccessfully" do
    sign_in(user.email, "test")

    expect(page).to have_current_path("/users/sign_in")
    expect(page).to have_content("Invalid Email or password")
  end

end
