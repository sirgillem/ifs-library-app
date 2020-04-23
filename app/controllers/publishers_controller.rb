# Control resources for publishers
class PublishersController < ApplicationController
  before_action :logged_in?
  before_action except: [:index, :show] { page_check_librarian publishers_path }

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
    redirect_to publishers_path
  end

  private

  # Protected parameters
  def pub_params
    params.require(:publisher).permit(:name, :website)
  end
end
