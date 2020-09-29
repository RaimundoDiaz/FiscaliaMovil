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
        format.html { redirect_to @person_in_procedure, notice: 'Person in procedure was successfully created.' }
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
      if @person_in_procedure.update(person_in_procedure_params)
        format.html { redirect_to @person_in_procedure, notice: 'Person in procedure was successfully updated.' }
        format.json { render :show, status: :ok, location: @person_in_procedure }
      else
        format.html { render :edit }
        format.json { render json: @person_in_procedure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /person_in_procedures/1
  # DELETE /person_in_procedures/1.json
  def destroy
    @person_in_procedure.destroy
    respond_to do |format|
      format.html { redirect_to person_in_procedures_url, notice: 'Person in procedure was successfully destroyed.' }
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
