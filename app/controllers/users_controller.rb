class UsersController < ApplicationController
  before_action :is_authorised

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    punk = User.find(params[:id])
    email = punk.email
    punk.destroy
    flash[:notice] = "User #{email} deleted"
    redirect_to users_path
  end

  private

  # Allow admins to adjust the following fields
  def user_params
    params.require(:user).permit(:username, :email, :password,
                                 :password_confirmation, :admin, :librarian)
  end
  
  # Only allow admin users access to these controls
  def is_authorised
    redirect_to(root_url) unless current_user and current_user.admin?
  end
end
