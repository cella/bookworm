require 'rails_helper'

RSpec.feature "user deletes a book" do
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
    click_link "Delete book"

    expect(page).to have_current_path("/")
    expect(page).to have_content("Book was successfully deleted")
  end
end
