module ShelfAuthorization
  extend ActiveSupport::Concern

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
end
