require 'rails_helper'

RSpec.feature "User signs out" do
  let(:user) { create(:user) }

  scenario "successfully" do
    sign_in(user.email, user.password)

    expect(page).to have_current_path("/")
    expect(page).to have_content "Signed in successfully"

    click_link "Log out"
    expect(page).to have_current_path("/")
    expect(page).to have_content "Signed out successfully"
  end
end
