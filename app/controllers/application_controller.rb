class ApplicationController < ActionController::Base
  def require_authentication
    return if current_user
    flash[:alert] = "You must be signed in to do that"
    redirect_to root_path
  end
end
