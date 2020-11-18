class ProceduresController < ApplicationController
  before_action :set_procedure, only: [:show, :edit, :update, :destroy]
  include ProceduresHelper

  # GET /procedures
  # GET /procedures.json
  def index
    if (current_user.local_prosecution.present?)
      @procedures = Procedure.where(:state => 0, :local_prosecution_in_charge_id => current_user.local_prosecution.id).order(created_at: :desc)
    end

    if (current_user.police_unit.present?)
      @procedures = Procedure.where(:state => 0, :police_unit_in_charge_id => current_user.police_unit.id).order(created_at: :desc)
    end
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
    victims_in_procedure = @procedure.person_in_procedures.where(role: 2)
    @victims = []
    victims_in_procedure.each do |victim|
      @victims.append([Person.find(victim.person_id), victim.witness_declaration])
    end

    #save list with all witnesses person of the procedure
    witnesses_in_procedure = @procedure.person_in_procedures.where(role: 1)
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

    if procedure_params[:classification] == "ODP"
      classification_procedure = 1

    elsif procedure_params[:classification] == "Flagrancia"
      classification_procedure = 0
    else
      classification_procedure = 2
    end

    selected_region = ""
    selected_sector = ""
    get_regiones
    @regiones.each do |region|
      if region[:codigo].to_s == procedure_params[:region].to_s
        selected_region = region[:nombre]
      end
      region[:comunas].each do |comuna|
        if comuna[:codigo].to_s == procedure_params[:sector].to_s
          selected_sector = comuna[:nombre]
        end
      end
    end



    d = procedure_params[:date].to_date
    t = procedure_params[:time].to_time


    @procedure = Procedure.new(classification: classification_procedure,
                               police_in_charge: PoliceMan.find(1),
                               police_unit_in_charge: PoliceMan.find(1).police_unit,
                               prosecutor_in_charge: Prosecutor.find(1),
                               local_prosecution_in_charge: Prosecutor.find(1).local_prosecution,
                               story: procedure_params[:story],
                               address: procedure_params[:address],
                               sector: selected_sector,
                               region: selected_region,
                               state: 0,
                               date_of_arrest: DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec, t.zone),
                               involves_deceased: procedure_params[:involves_deceased]
                               )
    respond_to do |format|
      if @procedure.save

        procedure_params[:tag_ids][1..procedure_params[:tag_ids].size].each do |tag|
          @tag = Tagging.new(tag: Tag.find_by_name(tag),
                             procedure: @procedure)
          @tag.save
        end

        procedure_params[:accuseds].each do |accused|
          @criminal = Person.new(name: accused[:name],
                               rut: accused[:rut])
          if @criminal.save!
            @criminal_in_procedure = PersonInProcedure.new(role: 0,
                                                           person: @criminal,
                                                           procedure: @procedure)
            @criminal_in_procedure.save
            @criminal_alias = AliasAccused.new(alias: accused[:alias],
                                           person: @criminal)
            @criminal_alias.save
            if procedure_params[:crimes]
              procedure_params[:crimes].each do |crime|
                @crime_in_accused = CrimeInAccused.new(preponderant: false,
                                                       crime: Crime.find_by_name(crime),
                                                       person: @criminal,
                                                       procedure: @procedure)
                @crime_in_accused.save
              end
            end

            @preponderan_crime_in_accused = CrimeInAccused.new(preponderant: true,
                                                               crime: Crime.find_by_name(procedure_params[:preponderant_crime]),
                                                               person: @criminal,
                                                               procedure: @procedure)
            @preponderan_crime_in_accused.save
          end
        end

        procedure_params[:victims].each do |victim|
          @victim = Person.new(name: victim[:name],
                               rut: victim[:rut],
                               deceased: victim[:deceased],
                               contact: victim[:contact]
                               )
          if @victim.save!
            @victim_in_procedure = PersonInProcedure.new(role: 2,
                                                         person: @victim,
                                                         procedure: @procedure,
                                                         witness_declaration: victim[:story])
            @victim_in_procedure.save
          end
        end

        procedure_params[:witness].each do |witness|
          @witness = Person.new(name: witness[:name],
                               rut: witness[:rut],
                               contact: witness[:contact]
          )
          if @witness.save!
            @witness_in_procedure = PersonInProcedure.new(role: 1,
                                                         person: @witness,
                                                         procedure: @procedure,
                                                         witness_declaration: witness[:story])
            @witness_in_procedure.save
          end
        end



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

  def procedure_params

    # Only allow a list of trusted parameters through.
    params.require(:procedure).permit(:date,:time,:classification,:involves_deceased,:address,:region,:sector,:preponderant_crime,:state, :story, crimes:[],
                                      tag_ids:[], :accuseds => [:name,:alias,:rut], :victims => [:name,:rut,:deceased,:contact,:story],
                                      :witness => [:name,:rut,:story,:contact])
  end
end
