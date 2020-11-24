class Admin::RegionalProsecutionsController < ApplicationController
  load_and_authorize_resource except: [:create]
  before_action :set_admin_regional_prosecution, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!
  include ProceduresHelper

  # GET /admin/regional_prosecutions
  # GET /admin/regional_prosecutions.json
  def index
    @regional_prosecutions = RegionalProsecution.not_deleted
  end

  # GET /admin/regional_prosecutions/new
  def new
    get_regiones
    @regional_prosecution = RegionalProsecution.new
  end

  # GET /admin/regional_prosecutions/1/edit
  def edit
  end

  # POST /admin/regional_prosecutions
  # POST /admin/regional_prosecutions.json
  def create
    x = RegionalProsecution.all.pluck(:id).sort[-1] + 1
    @regional_prosecution = RegionalProsecution.new(id: x, name: admin_regional_prosecution_params["name"], region: admin_regional_prosecution_params["region"].to_i)
    respond_to do |format|
      if @regional_prosecution.save
        format.html { redirect_to admin_regional_prosecutions_path, notice: 'Fiscalía Regional ha sido creada con éxito.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/regional_prosecutions/1
  # PATCH/PUT /admin/regional_prosecutions/1.json
  def update
    respond_to do |format|
      if @regional_prosecution.update(admin_regional_prosecution_params)
        format.html { redirect_to admin_regional_prosecutions_path, notice: 'Fiscalía Regional ha sido actualizada con éxito.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/regional_prosecutions/1
  # DELETE /admin/regional_prosecutions/1.json
  def destroy
    #@regional_prosecution.destroy
    @regional_prosecution.soft_delete
    @regional_prosecution.local_prosecutions.each {|local|
      local.soft_delete
      local.user.soft_delete
      local.prosecutors.each { |pros|
        pros.soft_delete
        pros.user.soft_delete
      }
    }

    respond_to do |format|
      format.html { redirect_to admin_regional_prosecutions_url, notice: 'Fiscalía Regional ha sido eliminada con éxito.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_regional_prosecution
      @regional_prosecution = RegionalProsecution.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_regional_prosecution_params
      params.fetch(:regional_prosecution, {}).permit(:id, :name, :region)
    end
end
