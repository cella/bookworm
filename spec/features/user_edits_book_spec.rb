require 'rails_helper'

RSpec.feature "user edits a book" do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  before do
    sign_in(user.email, user.password)
    visit "/books/#{book.id}"
    click_link "Edit book"
    expect(page).to have_current_path("/books/#{book.id}/edit")
    expect(page).to have_content("Edit The Great Gatsby")
  end

  scenario "successfully" do
    fill_in "Title", with: "The Great Catsby"
    fill_in "Author", with: "F Scoop Whiskgerald"
    fill_in "Year of release", with: "2004"
    fill_in "Number of pages", with: "120"
    fill_in "Description", with: "A cat tragedy"

    click_button "Save"

    expect(page).to have_current_path("/books/#{book.id}")
    expect(page).to have_content("Book was successfully updated")
    expect(page).to have_content("The Great Catsby")
    expect(page).to_not have_content("The Great Gatsby")
    expect(page).to have_content("F Scoop Whiskgerald")
  end

  scenario "unsuccessfully" do
    fill_in "Title", with: ""
    fill_in "Author", with: "F Scoop Whiskgerald"
    fill_in "Year of release", with: "2004"
    fill_in "Number of pages", with: "120"
    fill_in "Description", with: "A cat tragedy"

    click_button "Save"

    expect(page).to have_current_path("/books/#{book.id}")
    expect(page).to have_content("Book was not saved")
    expect(page).to have_content("Title can't be blank")
  end
end
