class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if(@book.save)
      flash[:notice] = "Book added successfully"
      redirect_to book_path(@book)
    else
      flash[:alert] = "Book was not saved"
      render 'new'
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  private

  def book_params
    params.require(:book).permit(:title, :page_count, :release_year, :description, :author)
  end
end
