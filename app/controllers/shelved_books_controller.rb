class ShelvedBooksController < ApplicationController
  def create
    shelf = Shelf.find(shelved_book_params[:shelf_id])
    book = Book.find(shelved_book_params[:book_id])

    ShelvedBook.create(shelf: shelf, book: book)

    flash[:notice] = "Book successfully added to #{shelf.title} shelf"
    redirect_to book_path(book)
  end

  private

  def shelved_book_params
    params.require(:shelved_book).permit(:book_id, :shelf_id)
  end
end