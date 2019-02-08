require "rails_helper"

RSpec.describe ShelvedBooksController do

  let!(:book) { create(:book) }
  let!(:shelf) { create(:shelf) }

  let(:params) do
    {
      shelved_book: {
        shelf_id: shelf.id,
        book_id: book.id
      }
    }
  end

  describe "#create" do
    context "successfully" do
      it "creates a new book record" do
        expect do
          post :create, params: params
        end.to change { ShelvedBook.count }.by(1)
      end

      it 'redirects to the book' do
        post :create, params: params

        expect(response).to redirect_to("/books/#{Book.last.id}")
      end

      it "includes flash message" do
        post :create, params: params

        expect(flash[:notice]).to be_present
      end
    end
  end
end
