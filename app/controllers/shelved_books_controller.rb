class ShelvedBooksController < ApplicationController
  before_action :require_authentication

  def create
    shelf = Shelf.find(shelved_book_params[:shelf_id])
    book = Book.find(shelved_book_params[:book_id])

    return unless can_manage_shelf?(shelf)
    ShelvedBook.create(shelf: shelf, book: book)

    flash[:notice] = "Book successfully added to #{shelf.title} shelf"
    redirect_to book_path(book)
  end

  def destroy
    @shelved_book = ShelvedBook.find_by(id: params[:id])
    return unless can_manage_shelf?(@shelved_book.shelf)
    @shelved_book.destroy
    flash[:notice] = 'Book was successfully removed'
    redirect_to shelf_path(@shelved_book.shelf)
  end

  private

  def can_manage_shelf?(shelf)
    if current_user == shelf.user
      true
    else
      authorization_redirect
      false
    end
  end

  def authorization_redirect
    flash[:alert] = "You don't have permission to manage this shelf"
    redirect_to root_path
  end

  def shelved_book_params
    params.require(:shelved_book).permit(:book_id, :shelf_id)
  end
end
