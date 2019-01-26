class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    book = Book.create(book_params)
    flash[:notice] = "Book added successfully"
    redirect_to book_path(book)
  end

  def show
    @book = Book.find(params[:id])
  end

  private

  def book_params
    params.require(:book).permit(:title, :page_count, :release_year, :description, :author)
  end
end
