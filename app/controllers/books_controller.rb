class BooksController < ApplicationController
  before_action :require_authentication, except: [:index, :show]

  def index
    @books = BookSearch.new(params[:query]).call
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    respond_to do |format|
      format.html do
        if(@book.save)
          flash[:notice] = "Book added successfully"
          redirect_to book_path(@book)
        else
          flash[:alert] = "Book was not saved"
          render 'new'
        end
      end

      format.json do
        if(@book.save)
          render @book
        else
          errors = { errors: @book.errors }
          render json: errors, status: :unprocessable_entity
        end
      end
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

    respond_to do |format|
      format.html do
        if update_book
          flash[:notice] = 'Book was successfully updated'
          redirect_to book_path(@book)
        else
          flash[:alert] = "Book was not saved"
          render 'edit'
        end
      end

      format.json do
        if update_book
          render @book
        else
          errors = { errors: @book.errors }
          render json: errors, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = 'Book was successfully deleted'
    redirect_to root_path
  end

  private

  def update_book
    @book.update(book_params)
  end

  def book_params
    params.require(:book).permit(:title, :page_count, :release_year, :description, :author, :query)
  end
end
