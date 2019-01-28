require 'rails_helper'

RSpec.feature "user edits a book" do
  let(:user) { User.create(email: "test@test.com", password: "password") }
  let(:book) do
    Book.create(title: "The Great Gatsby",
                author: "F. Scott Fitzgerald",
                release_year: 1925,
                page_count: 180,
                description: "This is a cool book")
  end

  scenario "successfully" do
    sign_in(user.email, user.password)
    visit "/books/#{book.id}"
    click_link "Edit book"
    expect(page).to have_current_path("/books/#{book.id}/edit")
    expect(page).to have_content("Edit The Great Gatsby")

    fill_in "Title", with: "The Great Catsby"
    fill_in "Author", with: "F Scoop Whiskgerald"
    fill_in "Year of release", with: "2004"
    fill_in "Number of pages", with: "120"
    fill_in "Description", with: "A cat tragedy"

    click_button "Save"

    expect(page).to have_current_path("/books/#{book.id}")
  end

  scenario "unsuccessfully" do
    user = User.create(email: "test@test.com", password: "password")
    book = Book.create(title: "The Great Gatsby",
                      author: "F. Scott Fitzgerald",
                      release_year: 1925,
                      page_count: 180,
                      description: "This is a cool book")

    sign_in(user.email, user.password)
    visit "/books/#{book.id}"
    click_link "Edit book"
    expect(page).to have_current_path("/books/#{book.id}/edit")
    expect(page).to have_content("Edit The Great Gatsby")

    fill_in "Title", with: ""

    click_button "Save"

    expect(page).to have_current_path("/books/#{book.id}")
    expect(page).to have_content("Book was not saved")
  end
end
