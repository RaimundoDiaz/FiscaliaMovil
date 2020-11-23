class Admin::PoliceStationsController < ApplicationController
  load_and_authorize_resource
  before_action :set_admin_police_station, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /admin/police_stations
  # GET /admin/police_stations.json
  def index
    @police_stations = PoliceStation.all
  end

  # GET /admin/police_stations/new
  def new
    @police_station = PoliceStation.new
  end

  # GET /admin/police_stations/1/edit
  def edit
  end

  # POST /admin/police_stations
  # POST /admin/police_stations.json
  def create
    x = PoliceStation.all.pluck(:id).sort[-1] + 1
    @police_station = PoliceStation.new(id: x, name: admin_police_station_params["name"], police_type: admin_police_station_params["police_type"].to_i, prefecture_id: admin_police_station_params["prefecture_id"].to_i)

    respond_to do |format|
      if @police_station.save
        format.html { redirect_to admin_police_stations_path, notice: 'Police station was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/police_stations/1
  # PATCH/PUT /admin/police_stations/1.json
  def update
    respond_to do |format|
      if @police_station.update(admin_police_station_params)
        format.html { redirect_to admin_police_stations_path, notice: 'Police station was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/police_stations/1
  # DELETE /admin/police_stations/1.json
  def destroy
    @police_station.destroy
    respond_to do |format|
      format.html { redirect_to admin_police_stations_url, notice: 'Police station was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_police_station
      @police_station = PoliceStation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_police_station_params
      params.fetch(:police_station, {}).permit(:name, :police_type, :prefecture_id)
    end
end
