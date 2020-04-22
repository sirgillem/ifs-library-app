class InstrumentSectionsController < ApplicationController
  before_action :set_instrument_section, only: [:show, :edit, :update, :destroy]

  # GET /instrument_sections
  # GET /instrument_sections.json
  def index
    @instrument_sections = InstrumentSection.all
  end

  # GET /instrument_sections/1
  # GET /instrument_sections/1.json
  def show
  end

  # GET /instrument_sections/new
  def new
    @instrument_section = InstrumentSection.new
  end

  # GET /instrument_sections/1/edit
  def edit
  end

  # POST /instrument_sections
  # POST /instrument_sections.json
  def create
    @instrument_section = InstrumentSection.new(instrument_section_params)

    respond_to do |format|
      if @instrument_section.save
        format.html { redirect_to @instrument_section, notice: 'Instrument section was successfully created.' }
        format.json { render :show, status: :created, location: @instrument_section }
      else
        format.html { render :new }
        format.json { render json: @instrument_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instrument_sections/1
  # PATCH/PUT /instrument_sections/1.json
  def update
    respond_to do |format|
      if @instrument_section.update(instrument_section_params)
        format.html { redirect_to @instrument_section, notice: 'Instrument section was successfully updated.' }
        format.json { render :show, status: :ok, location: @instrument_section }
      else
        format.html { render :edit }
        format.json { render json: @instrument_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instrument_sections/1
  # DELETE /instrument_sections/1.json
  def destroy
    @instrument_section.destroy
    respond_to do |format|
      format.html { redirect_to instrument_sections_url, notice: 'Instrument section was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instrument_section
      @instrument_section = InstrumentSection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instrument_section_params
      params.require(:instrument_section).permit(:name, :sequence)
    end
end
