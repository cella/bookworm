require 'rails_helper'

RSpec.feature "user edits a shelf" do
  let!(:user) { create(:user) }
  let!(:shelf) { create(:shelf, user: user) }

  before(:each) do
    sign_in(user.email, user.password)
  end

  scenario "successfully" do
    visit "/users/#{user.id}/shelves/#{shelf.id}"
    click_link "Edit shelf"
    expect(page).to have_current_path("/users/#{user.id}/shelves/#{shelf.id}/edit")

    fill_in "Title", with: ""
    click_button "Save"

    expect(page).to have_content("Shelf could not be updated")

    fill_in "Title", with: "Favorite Books"
    click_button "Save"

    expect(page).to have_current_path("/users/#{user.id}/shelves/#{shelf.id}")
    expect(page).to have_content("Shelf was successfully updated")
  end

  context "with another user's shelf" do
    let(:shelf) { create(:shelf) }
    scenario "unsuccessfully" do
      visit "/users/#{shelf.user.id}/shelves/#{shelf.id}/edit"
      expect(page).to have_content("You don't have permission to manage this shelf")
    end
  end
end
