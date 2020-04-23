class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Share authorisation methods with view helpers
  helper_method :librarian?

  # Provide the parameters for a nested publisher form
  def publisher_params
    [publisher_attributes: [:id, :name, :website]]
  end

  # Provide the parameters for a nested song part form
  def song_part_params
    [song_parts_attributes: [:id,
                             :name,
                             :scanned,
                             :notes,
                             :sequence,
                             :_destroy,
                             part_instruments_attributes: [
                               :id,
                               :instrument_id,
                               :_destroy
                             ]]]
  end

  def librarian?
    current_user && current_user.librarian?
  end

  private

    # Check that a user is logged in before showing anything
    def logged_in?
      redirect_to root_path unless current_user
    end

    # Check if the current user is a librarian before modifying anything
    def page_check_librarian(redirect = root_path)
      redirect_to redirect unless librarian?
    end
end
