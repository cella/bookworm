require "rails_helper"

RSpec.describe ShelvedBooksController do
  let(:current_user) { create(:user) }

  before do
    allow(controller).to receive(:current_user) { current_user }
  end

  let!(:book) { create(:book) }
  let!(:shelf) { create(:shelf, user: current_user) }

  # use this for a context to imply managing another user's shelved books
  # let!(:shelf) { create(:shelf) }

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
      it "creates a new shelved book record" do
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

  describe "#destroy" do
    let!(:shelved_book) { create(:shelved_book, shelf: shelf, book: book) }
    let(:params) do
      {
        id: shelved_book.id,
      }
    end

    it "deletes the shelved book record" do
      expect do
        delete :destroy, params: params
      end.to change { ShelvedBook.count }.by(-1)
    end
  end
end
