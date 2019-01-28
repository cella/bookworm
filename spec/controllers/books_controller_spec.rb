require "rails_helper"

RSpec.describe BooksController do
  let(:params) do
    {
      book: {
        title: 'The Great Catsby',
        page_count: 120,
        release_year: 2020,
        description: 'Gr8 book',
        author: 'Meowth'
      }
    }
  end

  describe "#create" do
    context "successfully" do
      it "creates a new book record" do
        expect do
          post :create, params: params
        end.to change { Book.count }.by(1)

        book = Book.last
        expect(book.title).to eql('The Great Catsby')
        expect(book.page_count).to eql(120)
        expect(book.release_year).to eql(2020)
        expect(book.description).to eql('Gr8 book')
        expect(book.author).to eql('Meowth')
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

    context "unsuccessfully" do
      it "doesn't create a new book record" do
        expect do
          post :create, params: { book: { title: '' } }
        end.not_to change { Book.count }
      end

      it 'does not redirect' do
        post :create, params: { book: { title: '' } }

        expect(response).to render_template(:new)
      end

      it "includes error message" do
        post :create, params: { book: { title: '' } }

        expect(flash[:alert]).to be_present
      end
    end
  end
end
