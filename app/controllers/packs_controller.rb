class PacksController < ApplicationController
  before_action :logged_in?
  before_action :librarian?, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_pack, only: [:show, :edit, :update, :destroy]

  # GET /packs
  # GET /packs.json
  def index
    @packs = Pack.all
  end

  # GET /packs/1
  # GET /packs/1.json
  def show
  end

  # GET /packs/new
  def new
    @pack = Pack.new
  end

  # GET /packs/1/edit
  def edit
  end

  # POST /packs
  # POST /packs.json
  def create
    @pack = Pack.new(pack_params)

    respond_to do |format|
      if @pack.save
        format.html { redirect_to @pack, notice: 'Pack was successfully created.' }
        format.json { render :show, status: :created, location: @pack }
      else
        format.html { render :new }
        format.json { render json: @pack.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /packs/1
  # PATCH/PUT /packs/1.json
  def update
    respond_to do |format|
      if @pack.update(pack_params)
        format.html { redirect_to @pack, notice: 'Pack was successfully updated.' }
        format.json { render :show, status: :ok, location: @pack }
      else
        format.html { render :edit }
        format.json { render json: @pack.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /packs/1
  # DELETE /packs/1.json
  def destroy
    @pack.destroy
    respond_to do |format|
      format.html { redirect_to packs_url, notice: 'Pack was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pack
      @pack = Pack.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pack_params
      params.require(:pack).permit(:name, :publisher_id, :serial)
    end

    # Check that a user is logged in before showing anything
    def logged_in?
      redirect_to '/' unless current_user
    end

    # Check if the current user is a librarian before modifying anything
    def librarian?
      redirect_to packs_path unless current_user && current_user.librarian?
    end
end