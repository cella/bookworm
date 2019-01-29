require 'rails_helper'

RSpec.feature "user deletes a book" do
  let(:user) { create(:user) }
  let!(:book) { create(:book) }

  scenario "successfully" do
    sign_in(user.email, user.password)
    click_link "View all books"

    click_link book.title
    expect(page).to have_current_path "/books/#{book.id}"
    click_link "Delete book"

    expect(page).to have_current_path("/")
    expect(page).to have_content("Book was successfully deleted")
    click_link "View all books"
    expect(page).to_not have_content(book.title)
  end
end
