class SongTemplatesController < ApplicationController
  before_action :set_song_template, only: [:show, :edit, :update, :destroy]

  # GET /song_templates
  # GET /song_templates.json
  def index
    @song_templates = SongTemplate.all
  end

  # GET /song_templates/1
  # GET /song_templates/1.json
  def show
  end

  # GET /song_templates/new
  def new
    @song_template = SongTemplate.new
  end

  # GET /song_templates/1/edit
  def edit
  end

  # POST /song_templates
  # POST /song_templates.json
  def create
    @song_template = SongTemplate.new(song_template_params)

    respond_to do |format|
      if @song_template.save
        format.html { redirect_to @song_template, notice: 'Song template was successfully created.' }
        format.json { render :show, status: :created, location: @song_template }
      else
        format.html { render :new }
        format.json { render json: @song_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /song_templates/1
  # PATCH/PUT /song_templates/1.json
  def update
    respond_to do |format|
      if @song_template.update(song_template_params)
        format.html { redirect_to @song_template, notice: 'Song template was successfully updated.' }
        format.json { render :show, status: :ok, location: @song_template }
      else
        format.html { render :edit }
        format.json { render json: @song_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /song_templates/1
  # DELETE /song_templates/1.json
  def destroy
    @song_template.destroy
    respond_to do |format|
      format.html { redirect_to song_templates_url, notice: 'Song template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song_template
      @song_template = SongTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_template_params
      params.require(:song_template).permit(:name)
    end
end
