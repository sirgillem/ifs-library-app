class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    # Check that a user is logged in before showing anything
    def logged_in?
      redirect_to root_path unless current_user
    end

    # Check if the current user is a librarian before modifying anything
    def librarian?(redirect = root_path)
      redirect_to redirect unless current_user && current_user.librarian?
    end
end
