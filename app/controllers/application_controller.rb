class ApplicationController < ActionController::Base
  def current_user
    respond_to do |format|
      format.html do
        # Delegate to Devise's #current_user
        super
      end

      format.json do
        @current_user ||= User.find_by(token: request.headers["Authorization"])
      end
    end
  end

  def require_authentication
    return if current_user
    respond_to do |format|
      format.html do
        flash[:alert] = "You must be signed in to do that"
        redirect_to root_path
      end
      format.json do
        head :unauthorized
      end
    end
  end
end
