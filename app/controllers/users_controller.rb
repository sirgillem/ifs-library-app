class UsersController < ApplicationController
  before_action :is_authorised

  def index
    @users = User.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
    punk = User.find(params[:id])
    email = punk.email
    punk.destroy
    flash[:notice] = "User #{email} deleted"
    redirect_to users_path
  end

  private
  
  # Only allow admin users access to these controls
  def is_authorised
    redirect_to(root_url) unless current_user and current_user.admin?
  end
end
