require 'rails_helper'

RSpec.describe 'User removes book frome shelf' do
  let(:user) { create(:user) }
  let!(:book) { create(:book) }
  let!(:shelf) { create(:shelf, user: user) }
  let!(:shelved_book) { ShelvedBook.create(shelf: shelf, book: book) }

  before(:each) do
    sign_in(user.email, user.password)
  end

  scenario 'successfully' do
    click_link "My shelves"
    click_link shelf.title
    expect(page).to have_current_path("/shelves/#{shelf.id}")

    within "table" do
      first('a[data-action=remove]').click
    end
    expect(page).to have_content("Book was successfully removed")
    expect(page).to_not have_content(book.title)
  end
end
