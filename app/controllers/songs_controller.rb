class SongsController < ApplicationController
  include ContributableController
  before_action :logged_in?
  before_action except: [:index, :catalogue, :show] { page_check_librarian songs_path }
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  # GET /songs
  # GET /songs.json
  def index
    @songs = Song.where(nil)
    filtering_params.each do |key, value|
      if value.present?
        value = s_to_duration(value) if ['min_dur', 'max_dur'].include?(key)
        @songs = @songs.public_send("filter_by_#{key}", value)
      end
    end
    @songs = @songs.sort_by(&:sort_key)
  end

  # GET /catalogue
  def catalogue
    @songs = Song.filter_by_label(true)
    filtering_params.each do |key, value|
      if value.present?
        value = s_to_duration(value) if ['min_dur', 'max_dur'].include?(key)
        @songs = @songs.public_send("filter_by_#{key}", value)
      end
    end
    @songs = @songs.sort_by(&:sort_key)
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @song = Song.new
    if params[:template_id].present?
      template = SongTemplate.find(params[:template_id])
      template.song_parts.each do |templ_part|
        new_part = templ_part.dup
        templ_part.instruments.each do |inst|
          new_part.instruments << inst
        end
        @song.song_parts << new_part
      end
    end
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Convert an input string to a duration in seconds
  def s_to_duration(time_string)
    parts = time_string.split(':')
    return nil if time_string.blank?
    # Prepend items to format hh:mm:ss
    parts.prepend '0' while parts.size < 3
    error_msg = 'Duration must be in format h:m:s (hours and minutes optional)'
    errors.add :base, error_msg if parts.size > 3
    begin
      parts[0].to_i * 3600 + parts[1].to_i * 60 + parts[2].to_i
    rescue StandardError
      errors.add :base, error_msg
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      if params[:song][:duration]
        params[:song][:duration] = s_to_duration(params[:song][:duration])
      end
      params.require(:song).permit(:title,
                                   :label,
                                   :publisher_id,
                                   :serial,
                                   :details,
                                   :notes_perf,
                                   :notes_lib,
                                   :pack_id,
                                   :recording,
                                   :style,
                                   :duration,
                                   :tempo,
                                   *publisher_params,
                                   *contributable_params,
                                   *song_part_params)
    end

    # Get allowed filtering parameters. Used to create scope calls in the song model.
    def filtering_params
      params.slice(:title, :label, :serial, :style, :min_dur, :max_dur,
                   :min_tempo, :max_tempo, :instrument)
    end
end
