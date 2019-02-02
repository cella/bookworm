require 'rails_helper'

RSpec.describe 'User adds book to shelf' do
  let(:user) { create(:user) }
  let!(:book) { create(:book) }
  let!(:shelf) { create(:shelf, user: user) }
  let!(:favorite_shelf) { create(:shelf, user: user, title: "Favorites" ) }
  before(:each) do
    sign_in(user.email, user.password)
  end

  scenario 'successfully' do
    click_link "View all books"
    click_link book.title

    within "h2" do
      expect(page).to have_content("Add to shelf")
    end

    select shelf.title, from: "My shelves"
    click_button "Add to shelf"

    expect(page).to have_current_path("/books/#{book.id}")
    expect(page).to have_content("Book successfully added to #{shelf.title} shelf")

    within "#shelved_book_shelf_id" do
      expect(page).to_not have_content(shelf.title)
      expect(page).to have_content(favorite_shelf.title)
    end

    select favorite_shelf.title, from: "My shelves"
    click_button "Add to shelf"

    expect(page).to_not have_content("My shelves")
    expect(page).to have_content("You have no available shelves")

    visit '/'
    click_link "My shelves"
    click_link shelf.title

    expect(page).to have_content(shelf.title)
    expect(page).to have_content(book.title)
  end
end
