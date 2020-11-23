class Admin::ProsecutorsController < ApplicationController
  before_action :set_admin_prosecutor, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /admin/prosecutors
  # GET /admin/prosecutors.json
  def index
    if current_user.prosecutor.present?
      @prosecutors = Prosecutor.all.where(local_prosecution: current_user.prosecutor.local_prosecution).order(:name)
    else
      @prosecutors = Prosecutor.all.order(:name)
    end

  end

  # GET /admin/prosecutors/new
  def new
    @prosecutor = Prosecutor.new
  end

  # GET /admin/prosecutors/1/edit
  def edit
  end

  # POST /admin/prosecutors
  # POST /admin/prosecutors.json
  def create
    if params[:prosecutor][:local_prosecution_id].nil?
      redirect_back(fallback_location: root_path)
      flash[:alert] = "No user selected"
    else
      @prosecutor = Prosecutor.new(admin_prosecutor_params)

      respond_to do |format|
        if @prosecutor.save
          format.html { redirect_to admin_prosecutors_path, notice: 'Prosecutor was successfully created.' }
        else
          format.html { render :new }
        end
      end
    end
  end

  # PATCH/PUT /admin/prosecutors/1
  # PATCH/PUT /admin/prosecutors/1.json
  def update
    respond_to do |format|
      if @prosecutor.update(admin_prosecutor_params)
        format.html { redirect_to admin_prosecutors_path, notice: 'Prosecutor was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/prosecutors/1
  # DELETE /admin/prosecutors/1.json
  def destroy
    @prosecutor.destroy
    respond_to do |format|
      format.html { redirect_to admin_prosecutors_url, notice: 'Prosecutor was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_prosecutor
      @prosecutor = Prosecutor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_prosecutor_params
      params.fetch(:prosecutor, {}).permit(:rut, :name, :local_prosecution_id)
    end
end
