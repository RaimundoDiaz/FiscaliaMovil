class Admin::OperatorsController < ApplicationController
  load_and_authorize_resource except: [:create]
  before_action :set_admin_operator, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /operators
  # GET /operators.json
  def index
    if current_user.local_prosecution.present?
      @operators = Operator.not_deleted.joins(:prosecutor).where(prosecutors: { local_prosecution: current_user.local_prosecution })
    else
      @operators = Operator.not_deleted.order(:name)
    end
  end

  # GET /operators/1
  # GET /operators/1.json
  def show
  end

  # GET /operators/new
  def new
    @operator = Operator.new
    @prosecutors = Prosecutor.not_deleted.where(local_prosecution: @operator.prosecutor.local_prosecution)
  end

  # GET /operators/1/edit
  def edit
    @prosecutors = Prosecutor.not_deleted.where(local_prosecution: @operator.prosecutor.local_prosecution)
  end

  # POST /operators
  # POST /operators.json
  def create
    @operator = Operator.new(admin_operator_params)

    respond_to do |format|
      if @operator.save
        format.html { redirect_to admin_operators_path, notice: 'Operador ha sido creado con éxito.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /operators/1
  # PATCH/PUT /operators/1.json
  def update
    respond_to do |format|
      if @operator.update(admin_operator_params)
        format.html { redirect_to admin_operators_path, notice: 'Operador ha sido actualizado con éxito.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /operators/1
  # DELETE /operators/1.json
  def destroy
    #@operator.destroy
    @operator.soft_delete
    @operator.user.soft_delete
    respond_to do |format|
      format.html { redirect_to admin_operators_url, notice: 'Operador ha sido eliminado con éxito.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_operator
      @operator = Operator.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_operator_params
      params.fetch(:operator, {}).permit(:rut, :name, :prosecutor_id)
    end
end
