class AliasAccusedsController < ApplicationController
  before_action :set_alias_accused, only: [:show, :edit, :update, :destroy]

  # GET /alias_accuseds
  # GET /alias_accuseds.json
  def index
    @alias_accuseds = AliasAccused.all
  end

  # GET /alias_accuseds/1
  # GET /alias_accuseds/1.json
  def show
  end

  # GET /alias_accuseds/new
  def new
    @alias_accused = AliasAccused.new
  end

  # GET /alias_accuseds/1/edit
  def edit
  end

  # POST /alias_accuseds
  # POST /alias_accuseds.json
  def create
    @alias_accused = AliasAccused.new(alias_accused_params)

    respond_to do |format|
      if @alias_accused.save
        format.html { redirect_to @alias_accused, notice: 'Alias accused was successfully created.' }
        format.json { render :show, status: :created, location: @alias_accused }
      else
        format.html { render :new }
        format.json { render json: @alias_accused.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alias_accuseds/1
  # PATCH/PUT /alias_accuseds/1.json
  def update
    respond_to do |format|
      if @alias_accused.update(alias_accused_params)
        format.html { redirect_to @alias_accused, notice: 'Alias accused was successfully updated.' }
        format.json { render :show, status: :ok, location: @alias_accused }
      else
        format.html { render :edit }
        format.json { render json: @alias_accused.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alias_accuseds/1
  # DELETE /alias_accuseds/1.json
  def destroy
    @alias_accused.destroy
    respond_to do |format|
      format.html { redirect_to alias_accuseds_url, notice: 'Alias accused was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alias_accused
      @alias_accused = AliasAccused.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def alias_accused_params
      params.require(:alias_accused).permit(:alias, :person_id)
    end
end
