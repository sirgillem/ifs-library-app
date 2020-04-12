# Control resources for publishers
class PublishersController < ApplicationController
  before_action :logged_in?
  before_action :librarian?, only: [:new, :create, :edit, :update, :destroy]

  def index
    @publishers = Publisher.all
  end

  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new(pub_params)
    if @publisher.save
      redirect_to @publisher
    else
      render 'new'
    end
  end

  def show
    @publisher = Publisher.find(params[:id])
  end

  def edit
    @publisher = Publisher.find(params[:id])
  end

  def update
    @publisher = Publisher.find(params[:id])
    if @publisher.update(pub_params)
      flash[:notice] = 'Publisher updated'
      redirect_to @publisher
    else
      render 'edit'
    end
  end

  def destroy
    pub = Publisher.find(params[:id])
    pub.destroy
    flash[:notice] = "Publisher #{pub.name} deleted"
    redirect_to 'index'
  end

  private

  # Check if the current user is a librarian before modifying anything
  def librarian?
    redirect_to publishers_path unless current_user && current_user.librarian?
  end

  # Check if user is logged in before displaying anyting
  def logged_in?
    redirect_to root_url unless current_user
  end

  # Protected parameters
  def pub_params
    params.require(:publisher).permit(:name, :website)
  end
end
