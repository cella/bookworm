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

      it "sets errors on @book" do
        post :create, params: { book: { title: '' } }

        expect(assigns[:book].errors).to be_present
      end
    end
  end

  describe "#update" do
    let(:book) { create(:book) }

    context "successfully" do
      before do
        put :update, params: {
          id: book.id,
          book: {
            title: "Even better title",
            description: "Sweet book",
            release_year: 2018,
            page_count: 22,
            author: "Blues Clues"
          }
        }
      end

      it "updates book with valid params" do
        book.reload
        expect(book.title).to eq("Even better title")
      end

      it "redirects to show" do
        expect(response).to redirect_to("/books/#{book.id}")
      end

      it "includes flash message" do
        expect(flash[:notice]).to be_present
      end
    end

    context "unsuccessfully" do
      before { put :update, params: { id: book.id, book: { title: "" }} }

      it "doesn't save book params" do
        book.reload
        expect(book.title).to eq("The Great Gatsby")
      end

      it "does not redirect" do
        expect(response).to render_template(:edit)
      end

      it "includes error message" do
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "#destroy" do
    let!(:book) { create(:book) }

    it "deletes book" do
      expect do
        delete :destroy, params: { id: book.id }
      end.to change { Book.count }.by(-1)
    end

    it 'redirects to the book' do
      delete :destroy, params: { id: book.id }
      expect(response).to redirect_to("/")
    end

    it "includes flash message" do
      delete :destroy, params: { id: book.id }

      expect(flash[:notice]).to be_present
    end
  end

  describe "#index" do
    let!(:book) { create(:book) }
    let!(:anna_book) { create(:book, :anna) }

    it "includes list of books" do
      get :index
      expect(assigns(:books)).to eq([book, anna_book])
    end

    it "renders index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "adds filtering via search param" do
      get :index, params: { query: "Great Gatsby" }
      expect(assigns(:books)).to eq([book])
    end

    it "returns no results" do
      get :index, params: { query: "Rad book" }
      expect(assigns(:books)).to eq([])
    end
  end
end
