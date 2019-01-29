class BooksController < ApplicationController

  def index
    @books = Book.search(params[:query])
  end

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

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      flash[:notice] = 'Book was successfully updated'
      redirect_to book_path(@book)
    else
      flash[:alert] = "Book was not saved"
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = 'Book was successfully deleted'
    redirect_to root_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :page_count, :release_year, :description, :author, :query)
  end
end
