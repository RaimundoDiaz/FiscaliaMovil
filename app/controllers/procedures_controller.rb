class ProceduresController < ApplicationController
  before_action :set_procedure, only: [:show, :edit, :update, :destroy]
  include ProceduresHelper

  # GET /procedures
  # GET /procedures.json
  def index
    @procedures = Procedure.all.order(created_at: :desc)
  end

  # GET /procedures/1
  # GET /procedures/1.json
  def show
    #save list with all accuseds person of the procedure
    accuseds_in_procedure = @procedure.person_in_procedures.where(role: 0)
    @accuseds = []
    accuseds_in_procedure.each do |accused|
      @accuseds.append(Person.find(accused.person_id))
    end

    #save list with all victims person of the procedure
    victims_in_procedure = @procedure.person_in_procedures.where(role: 1)
    @victims = []
    victims_in_procedure.each do |victim|
      @victims.append([Person.find(victim.person_id), victim.witness_declaration])
    end

    #save list with all witnesses person of the procedure
    witnesses_in_procedure = @procedure.person_in_procedures.where(role: 2)
    @witnesses = []
    witnesses_in_procedure.each do |witness|
      @witnesses.append([Person.find(witness.person_id), witness.witness_declaration])
    end
  end

  # GET /procedures/new
  def new
    @procedure = Procedure.new
    get_regiones
  end

  # GET /procedures/1/edit
  def edit
  end

  # POST /procedures
  # POST /procedures.json
  def create

    if proceduce_params[:classification] == "ODP"
      classification_procedure = 1

    elsif proceduce_params[:classification] == "Flagrancia"
      classification_procedure = 0
    else
      classification_procedure = 2
    end




    puts(proceduce_params[:date]+proceduce_params[:time])
    @procedure = Procedure.new(classification: classification_procedure,
                               police_in_charge: 1,
                               police_unit_in_charge: 1,
                               prosecutor_in_charge: 1,
                               local_prosecution_in_charge: 1,
                               story: proceduce_params[:story],
                               address: proceduce_params[:address],
                               sector: proceduce_params[:sector],
                               region: proceduce_params[:region],
                               state: 0,
                               date_of_arrest: (proceduce_params[:date]+proceduce_params[:time]).to_datetime



                               )

    respond_to do |format|
      if @procedure.save
        format.html { redirect_to @procedure, notice: 'Procedure was successfully created.' }
        format.json { render :show, status: :created, location: @procedure }
      else
        format.html { render :new }
        format.json { render json: @procedure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /procedures/1
  # PATCH/PUT /procedures/1.json
  def update
    respond_to do |format|
      if @procedure.update(procedure_params)
        format.html { redirect_to @procedure, notice: 'Procedure was successfully updated.' }
        format.json { render :show, status: :ok, location: @procedure }
      else
        format.html { render :edit }
        format.json { render json: @procedure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /procedures/1
  # DELETE /procedures/1.json
  def destroy
    @procedure.destroy
    respond_to do |format|
      format.html { redirect_to procedures_url, notice: 'Procedure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_procedure
    @procedure = Procedure.find(params[:id])
  end

  def proceduce_params

    # Only allow a list of trusted parameters through.
    params.require(:procedure).permit(:date,:time,:classification,:address,:region,:sector,:preponderant_crime, :story, crimes:[],
                                      tag_ids:[], :accuseds => [:name,:alias,:rut], :victims => [:name,:rut,:deceased,:contact,:story],
                                      :witness => [:name,:rut,:story,:contact])
  end
end
