class CrimeInAccusedsController < ApplicationController
  before_action :set_crime_in_accused, only: [:show, :edit, :update, :destroy]

  # GET /crime_in_accuseds
  # GET /crime_in_accuseds.json
  def index
    @crime_in_accuseds = CrimeInAccused.all
  end

  # GET /crime_in_accuseds/1
  # GET /crime_in_accuseds/1.json
  def show
  end

  # GET /crime_in_accuseds/new
  def new
    @crime_in_accused = CrimeInAccused.new
  end

  # GET /crime_in_accuseds/1/edit
  def edit
  end

  # POST /crime_in_accuseds
  # POST /crime_in_accuseds.json
  def create
    @crime_in_accused = CrimeInAccused.new(crime_in_accused_params)

    respond_to do |format|
      if @crime_in_accused.save
        format.html { redirect_to @crime_in_accused, notice: 'Crime in accused was successfully created.' }
        format.json { render :show, status: :created, location: @crime_in_accused }
      else
        format.html { render :new }
        format.json { render json: @crime_in_accused.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crime_in_accuseds/1
  # PATCH/PUT /crime_in_accuseds/1.json
  def update
    respond_to do |format|
      if @crime_in_accused.update(crime_in_accused_params)
        format.html { redirect_to @crime_in_accused, notice: 'Crime in accused was successfully updated.' }
        format.json { render :show, status: :ok, location: @crime_in_accused }
      else
        format.html { render :edit }
        format.json { render json: @crime_in_accused.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crime_in_accuseds/1
  # DELETE /crime_in_accuseds/1.json
  def destroy
    @crime_in_accused.destroy
    respond_to do |format|
      format.html { redirect_to crime_in_accuseds_url, notice: 'Crime in accused was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crime_in_accused
      @crime_in_accused = CrimeInAccused.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def crime_in_accused_params
      params.require(:crime_in_accused).permit(:preponderant, :crime_id, :person_id, :procedure_id)
    end
end
