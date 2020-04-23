class SongPartsController < ApplicationController
  before_action :logged_in?
  before_action except: [:index, :show] { page_check_librarian song_parts_path }
  before_action :set_song_part, only: [:show, :edit, :update, :destroy]

  # GET /song_parts
  # GET /song_parts.json
  def index
    @song_parts = SongPart.all_parts
  end

  # GET /song_parts/1
  # GET /song_parts/1.json
  def show
  end

  # GET /song_parts/new
  def new
    @song_part = SongPart.new
  end

  # GET /song_parts/1/edit
  def edit
  end

  # POST /song_parts
  # POST /song_parts.json
  def create
    @song_part = SongPart.new(song_part_params)

    respond_to do |format|
      if @song_part.save
        format.html { redirect_to @song_part, notice: 'Song part was successfully created.' }
        format.json { render :show, status: :created, location: @song_part }
      else
        format.html { render :new }
        format.json { render json: @song_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /song_parts/1
  # PATCH/PUT /song_parts/1.json
  def update
    respond_to do |format|
      if @song_part.update(song_part_params)
        format.html { redirect_to @song_part, notice: 'Song part was successfully updated.' }
        format.json { render :show, status: :ok, location: @song_part }
      else
        format.html { render :edit }
        format.json { render json: @song_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /song_parts/1
  # DELETE /song_parts/1.json
  def destroy
    @song_part.destroy
    respond_to do |format|
      format.html { redirect_to song_parts_url, notice: 'Song part was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song_part
      @song_part = SongPart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_part_params
      params.require(:song_part).permit(:song_id,
                                        :name,
                                        :scanned,
                                        :notes,
                                        :song_template_id,
                                        :sequence)
    end
end
