class Admin::PoliceUnitsController < ApplicationController
  load_and_authorize_resource except: [:create]
  before_action :set_admin_police_unit, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /admin/police_units
  # GET /admin/police_units.json
  def index
    @police_units = PoliceUnit.not_deleted
  end

  # GET /admin/police_units/new
  def new
    @police_unit = PoliceUnit.new
  end

  # GET /admin/police_units/1/edit
  def edit
  end

  # POST /admin/police_units
  # POST /admin/police_units.json
  def create
    x = PoliceUnit.all.pluck(:id).sort[-1] + 1
    @police_unit = PoliceUnit.new(id: x, name: admin_police_unit_params["name"], police_station_id: admin_police_unit_params["police_station_id"].to_i)

    respond_to do |format|
      if @police_unit.save
        format.html { redirect_to admin_police_units_path, notice: 'Unidad Policial ha sido creado con éxito.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/police_units/1
  # PATCH/PUT /admin/police_units/1.json
  def update
    respond_to do |format|
      if @police_unit.update(admin_police_unit_params)
        format.html { redirect_to admin_police_units_path, notice: 'Unidad Policial ha sido actualizada con éxito.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/police_units/1
  # DELETE /admin/police_units/1.json
  def destroy
    #@police_unit.destroy
    @police_unit.soft_delete
    @police_unit.users.each { |user|
      user.soft_delete
    }
    respond_to do |format|
      format.html { redirect_to admin_police_units_url, notice: 'Unidad Policial ha sido eliminada con éxito.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_police_unit
      @police_unit = PoliceUnit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_police_unit_params
      params.fetch(:police_unit, {}).permit(:name, :police_station_id)
    end
end
