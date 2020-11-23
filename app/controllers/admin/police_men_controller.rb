class Admin::PoliceMenController < ApplicationController
  load_and_authorize_resource
  before_action :set_admin_police_man, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /admin/police_men
  # GET /admin/police_men.json
  def index
    @police_men = PoliceMan.all.order(:name)
  end

  # GET /admin/police_men/new
  def new
    @police_man = PoliceMan.new
  end

  # GET /admin/police_men/1/edit
  def edit
  end

  # POST /admin/police_men
  # POST /admin/police_men.json
  def create
    @police_man = PoliceMan.new(admin_police_man_params)

    respond_to do |format|
      if @police_man.save
        format.html { redirect_to admin_police_men_path, notice: 'Police man was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/police_men/1
  # PATCH/PUT /admin/police_men/1.json
  def update
    respond_to do |format|
      if @police_man.update(admin_police_man_params)
        format.html { redirect_to admin_police_men_path, notice: 'Police man was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/police_men/1
  # DELETE /admin/police_men/1.json
  def destroy
    @police_man.destroy
    respond_to do |format|
      format.html { redirect_to admin_police_men_url, notice: 'Police man was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_police_man
      @police_man = PoliceMan.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_police_man_params
      params.fetch(:police_man, {}).permit(:name, :rut, :badge)
    end
end
