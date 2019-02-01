require 'rails_helper'

RSpec.feature "User searches book" do
  let!(:book) { create(:book) }
  let!(:anna_book) { create(:book, :anna)}

  before do
    user = create(:user)
    sign_in(user.email, user.password)
    expect(page).to have_current_path("/")

    click_link "View all books"

    expect(page).to have_current_path("/books")
    expect(page).to have_content("2 books found")
  end

  scenario "with title" do
    fill_in "query", with: "Great Gatsby"
    click_button "Search"

    expect(page).to have_content("1 book found")
    expect(page).to have_content("The Great Gatsby")
    expect(page).to_not have_content("Anna Karenina")
  end

  scenario "with author" do
    fill_in "query", with: "F. Scott Fitzgerald"
    click_button "Search"

    expect(page). to have_content("1 book found")
    expect(page).to have_content("The Great Gatsby")
    expect(page).to_not have_content("Anna Karenina")
  end

  scenario "with description" do
    fill_in "query", with: "cool"
    click_button "Search"

    expect(page). to have_content("2 books found")
    expect(page).to have_content("The Great Gatsby")
    expect(page).to have_content("Anna Karenina")
  end

  scenario "unsuccessfully" do
    fill_in "query", with: "Random book"
    click_button "Search"

    expect(page). to have_content("0 books found")
    expect(page).to_not have_content("The Great Gatsby")
    expect(page).to_not have_content("Anna Karenina")
  end
end
