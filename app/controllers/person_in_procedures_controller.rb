class PersonInProceduresController < ApplicationController
  before_action :set_person_in_procedure, only: [:show, :edit, :update, :destroy]

  # GET /person_in_procedures
  # GET /person_in_procedures.json
  def index
    @person_in_procedures = PersonInProcedure.all
  end

  # GET /person_in_procedures/1
  # GET /person_in_procedures/1.json
  def show
  end

  # GET /person_in_procedures/new
  def new
    @person_in_procedure = PersonInProcedure.new
  end

  # GET /person_in_procedures/1/edit
  def edit
  end

  # POST /person_in_procedures
  # POST /person_in_procedures.json
  def create
    @person_in_procedure = PersonInProcedure.new(person_in_procedure_params)

    respond_to do |format|
      if @person_in_procedure.save
        format.html { redirect_to @person_in_procedure, notice: 'Se ha creado un imputado con éxito.' }
        format.json { render :show, status: :created, location: @person_in_procedure }
      else
        format.html { render :new }
        format.json { render json: @person_in_procedure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /person_in_procedures/1
  # PATCH/PUT /person_in_procedures/1.json
  def update
    respond_to do |format|
      if @person_in_procedure.update(state: params[:state])
        @register = RegistryInAccused.find_by(accused_id: @person_in_procedure.id)
        if @register.present?
          @register.update(prosecutor_id: params[:prosecutor])
        else
          RegistryInAccused.create(prosecutor_id: params[:prosecutor], accused_id: @person_in_procedure.id)
        end
        format.html { redirect_to request.referrer, notice: 'Se ha pronunciado sobre un imputado con éxito.' }
        format.json { render :show, status: :ok, location: @person_in_procedure }
      else
        format.html { render request.referrer }
        format.json { render json: @person_in_procedure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /person_in_procedures/1
  # DELETE /person_in_procedures/1.json
  def destroy
    @person_in_procedure.destroy
    respond_to do |format|
      format.html { redirect_to person_in_procedures_url, notice: 'Se ha eliminado un imputado con éxito.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person_in_procedure
      @person_in_procedure = PersonInProcedure.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def person_in_procedure_params
      params.require(:person_in_procedure).permit(:person_id, :procedure_id, :role)
    end
end
