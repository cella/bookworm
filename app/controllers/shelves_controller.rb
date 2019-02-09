class ShelvesController < ApplicationController
  before_action :require_authentication

  def new
    @shelf = Shelf.new
  end

  def show
    @shelf = Shelf.find(params[:id])
    @shelved_books = @shelf.shelved_books.includes(:book)
  end

  def index
    @user = User.find(params[:user_id])
    @shelves = @user.shelves
  end

  def create
    @shelf = current_user.shelves.new(shelf_params)

    if @shelf.save
      flash[:notice] = "Shelf added successfully"
      redirect_to user_shelf_path(current_user, @shelf)
    else
      flash[:alert] = "Shelf was not saved"
      render 'new'
    end
  end

  private

  def shelf_params
    params.require(:shelf).permit(:title)
  end
end
