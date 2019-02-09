require 'rails_helper'

RSpec.feature "user views shelves" do
  let(:user) { create(:user) }
  let!(:shelf) { create(:shelf, user: user) }
  let!(:other_user_shelf) { create(:shelf, title: "My All Time Favs") }

  before(:each) do
    sign_in(user.email, user.password)
  end

  scenario "shows only the user's shelves" do
    click_link "My shelves"
    expect(page).to have_current_path("/users/#{user.id}/shelves")

    within "h1" do
      expect(page).to have_content("My shelves")
    end

    expect(page).to have_content(shelf.title)
    expect(page).to_not have_content(other_user_shelf.title)
  end

  scenario "viewing another user's shelves" do
    other_user = other_user_shelf.user
    visit("/users/#{other_user.id}/shelves")

    within "h1" do
      expect(page).to have_content("#{other_user.email}'s shelves")
    end

    expect(page).to have_content(other_user_shelf.title)
    expect(page).to_not have_content(shelf.title)
  end
end
