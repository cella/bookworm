require 'rails_helper'

RSpec.feature "user views all books" do
  scenario "successfully" do
    user = create(:user)
    book = create(:book)

    book2 = create(:book,
                title: "Anna Karenina",
                author: "Leo Tolstoy",
                release_year: 1877,
                page_count: 964,
                description: "This is an even cool book")

    sign_in(user.email, user.password)

    visit "/"
    click_link "View all books"

    expect(page).to have_current_path("/books")
    expect(page).to have_content("Books")

    expect(page).to have_content("The Great Gatsby")
    expect(page).to have_content("F. Scott Fitzgerald")
    expect(page).to have_content("1925")

    expect(page).to have_content("Anna Karenina")
    expect(page).to have_content("Leo Tolstoy")
    expect(page).to have_content("1877")
  end
end
