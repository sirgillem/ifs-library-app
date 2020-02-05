class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Temporary homepage
  def home
    render html: 'Home page under construction'
  end

  # Temporary other page
  def temp
    render html: 'Catalogue under construction'
  end
end
