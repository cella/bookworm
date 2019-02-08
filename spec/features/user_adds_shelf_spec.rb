require 'rails_helper'

RSpec.feature "user adds a new shelf" do

  let(:user) { create(:user) }

  before(:each) do
    sign_in(user.email, user.password)
    expect(page).to have_current_path("/")
    click_link "Add a shelf"
  end

  scenario "successfully" do
    expect(page).to have_current_path("/shelves/new")
    expect(page).to have_content("Add a new shelf")

    fill_in "Title", with: ""
    click_button "Save"

    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Shelf was not saved")

    fill_in "Title", with: "To Read"
    click_button "Save"

    expect(page).to have_current_path("/shelves/#{Shelf.last.id}")
    expect(page).to have_content("Shelf added successfully")
    expect(page).to have_content("To Read Shelf")
  end
end
