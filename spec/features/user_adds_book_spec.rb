require 'rails_helper'

RSpec.feature "user adds a new book" do

  before(:each) do
    user = User.create(email: "test@test.com", password: "password")
    sign_in(user.email, user.password)
    expect(page).to have_current_path("/")
    click_link "Add a book"
  end

  scenario "successfully" do
    expect(page).to have_current_path("/books/new")
    expect(page).to have_content("Add a new book")

    fill_in "Title", with: "The Great Gatsby"
    fill_in "Author", with: "F. Scott Fitzgerald"
    fill_in "Year of release", with: "1925"
    fill_in "Description", with: "This is a cool book"
    fill_in "Number of pages", with: "180"

    click_button "Save"

    expect(page).to have_current_path("/books/#{Book.last.id}")
    expect(page).to have_content("Book added successfully")
    expect(page).to have_content("The Great Gatsby")
    expect(page).to have_content("by F. Scott Fitzgerald")
    expect(page).to have_content("Published in 1925")
    expect(page).to have_content("This is a cool book")
    expect(page).to have_content("180 pages")
  end

  scenario "unsuccessfully" do
    expect(page).to have_current_path("/books/new")
    expect(page).to have_content("Add a new book")

    fill_in "Author", with: "F. Scott Fitzgerald"
    fill_in "Year of release", with: "1925"
    fill_in "Description", with: "This is a cool book"
    fill_in "Number of pages", with: "180"

    click_button "Save"

    expect(page).to have_current_path("/books")
    expect(page).to have_content("Book was not saved")
    expect(page).to have_content("Title can't be blank")
  end
end
