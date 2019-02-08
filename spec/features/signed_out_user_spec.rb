require 'rails_helper'

RSpec.feature "User is signed out" do

  let(:expect_root_redirect) do
    expect(page).to have_content("You must be signed in to do that")
    expect(page).to have_current_path("/")
  end

  scenario "Can't manage books" do
    visit "/"
    expect(page).to_not have_content("Add a book")

    visit "books/new"
    expect_root_redirect

    book = create(:book)

    visit "books/#{book.id}/edit"
    expect_root_redirect

    click_link "View all books"

    expect(page).to have_content(book.title)

    visit "/books/#{book.id}"

    expect(page).to have_content(book.author)
    expect(page).to_not have_content("Add to shelf")
    expect(page).to_not have_content("Edit book")
    expect(page).to_not have_content("Delete book")
  end

  scenario "Can't manage shelves and books on it" do
    visit "/"
    expect(page).to_not have_content("Add a shelf")
    expect(page).to_not have_content("My shelves")

    visit "/shelves/new"
    expect_root_redirect
  end
end
