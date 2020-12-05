class Admin::ProsecutorsController < ApplicationController
  load_and_authorize_resource except: [:create]
  before_action :set_admin_prosecutor, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /admin/prosecutors
  # GET /admin/prosecutors.json
  def index
    if current_user.local_prosecution.present?
      @prosecutors = Prosecutor.not_operators.where(local_prosecution: current_user.local_prosecution).order(:name)
    else
      @prosecutors = Prosecutor.not_operators.order(:name)
    end

  end

  # GET /admin/prosecutors/new
  def new
    @operador = params["operador"]
    if @operador == "true"
      @operador = true
    else
      @operador = false
    end
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
          format.html { redirect_to admin_prosecutors_path, notice: 'Fiscal ha sido creado con éxito.' }
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
        format.html { redirect_to admin_prosecutors_path, notice: 'Fiscal ha sido actualizado con éxito.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/prosecutors/1
  # DELETE /admin/prosecutors/1.json
  def destroy
    #@prosecutor.destroy
    @prosecutor.soft_delete
    @prosecutor.user.soft_delete
    respond_to do |format|
      format.html { redirect_to admin_prosecutors_url, notice: 'Fiscal ha sido eliminado con éxito.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_prosecutor
      @prosecutor = Prosecutor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_prosecutor_params
      params.fetch(:prosecutor, {}).permit(:rut, :name, :local_prosecution_id, :prosecutor_on_duty)
    end
end
