class ProceduresController < ApplicationController
  load_and_authorize_resource :except => [:create]
  before_action :set_procedure, only: [:show, :edit, :update, :destroy]
  include ProceduresHelper

  # GET /procedures
  # GET /procedures.json
  def index
    if current_user.prosecutor.present?
      @pagy, @procedures = pagy(Procedure.where(:state => 0, :local_prosecution_in_charge_id => current_user.prosecutor.local_prosecution.id).or(Procedure.where(:state => 2, :creator_id => current_user.id, :local_prosecution_in_charge_id => current_user.prosecutor.local_prosecution.id)).order(created_at: :desc))
    elsif current_user.police_unit.present?
      @pagy, @procedures = pagy(Procedure.where(:state => 2, :creator_id => current_user.id, :police_unit_in_charge_id => current_user.police_unit.id).or(Procedure.where(:state => 3, :police_unit_in_charge_id => current_user.police_unit.id)).order(created_at: :desc))
      puts(@procedures)
    elsif current_user.admin?
      @procedures = []
    end
  end

  # GET /procedures/1
  # GET /procedures/1.json
  def show
    #save list with all accuseds person of the procedure
    @preponderant_crime = @procedure.crime_in_accuseds.find_by(preponderant: true)
    @crimes = @procedure.crime_in_accuseds.where(preponderant: false).uniq { |s| s.crime.id }
    accuseds_in_procedure = @procedure.person_in_procedures.where(role: 0)
    @accuseds = []
    accuseds_in_procedure.each do |accused|
      @accuseds.append([Person.find(accused.person_id), accused.state, accused.id, accused.prosecutor_pronounced])
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
    gon.fiscales = Prosecutor.not_deleted
  end

  # GET /procedures/1/edit
  def edit
    @procedure = Procedure.find(params[:id])
    @preponderant_crime = @procedure.crime_in_accuseds.find_by(preponderant: true)
    @crimes = @procedure.crime_in_accuseds.where(preponderant: false).uniq { |s| s.crime.id }
    @accuseds = @procedure.person_in_procedures.where(role: 0)
    @victims = @procedure.person_in_procedures.where(role: 2)
    @witnesses = @procedure.person_in_procedures.where(role: 1)
    @classification_dic = {"Flagrancy" => "Flagrancia", "Pending arrest warrant" => "ODP", "Both" => "Ambas"}
    @photos = @procedure.photos
    @videos = @procedure.videos
    @documents = @procedure.documents
    get_regiones
    @regiones.each do |region|
      if region[:nombre].to_s == @procedure.region
        @selected_region = region[:codigo]
      end
      region[:comunas].each do |comuna|
        if comuna[:nombre].to_s == @procedure.sector
          @selected_sector = comuna[:codigo]
        end
      end
    end

    gon.sector = @selected_sector
    gon.fiscales = Prosecutor.not_deleted
  end

  # POST /procedures
  # POST /procedures.json
  def create
    authorize! :create, Procedure

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


    dateOfArrest = Time.zone.local(d.year, d.month, d.day, t.hour, t.min, t.sec)

    @procedure = Procedure.new(classification: classification_procedure,
                               creator: current_user,
                               police_in_charge: PoliceMan.find(procedure_params[:police_in_charge]),
                               police_unit_in_charge: PoliceUnit.find(procedure_params[:police_unit_in_charge]),
                               local_prosecution_in_charge: LocalProsecution.find(procedure_params[:prosecution_in_charge]),
                               story: procedure_params[:story],
                               address: procedure_params[:address],
                               sector: selected_sector,
                               region: selected_region,
                               state: params[:state].to_i,
                               date_of_arrest: dateOfArrest,
                               involves_deceased: procedure_params[:involves_deceased])

    respond_to do |format|
      if procedure_params[:accuseds]
        if @procedure.save!

          if procedure_params[:photos] != nil
            procedure_params[:photos].each_with_index do |photo,i|
              @photo = Photo.new(description: procedure_params[:photo_descriptions][i], procedure: @procedure)
              @photo.photo.attach(photo)
              @photo.save!
            end
          end

          if procedure_params[:videos] != nil
            procedure_params[:videos].each_with_index do |video,i|
              @video = Video.new(description: procedure_params[:video_descriptions][i], procedure: @procedure)
              @video.video.attach(video)
              @video.save!
            end
          end

          if procedure_params[:documents] != nil
            procedure_params[:documents].each_with_index do |document,i|
              @document = Document.new(description: procedure_params[:document_descriptions][i],name: procedure_params[:document_names][i], procedure: @procedure)
              @document.document.attach(document)
              @document.save!
            end
          end

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
                                                             procedure: @procedure,
                                                             state: 0)
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

          if procedure_params[:victims]
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
          end


          if procedure_params[:witness]
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
          end

          #si el procedimiento se envia, se mandan las notificaciones pertinentes
          if @procedure.state == "Open"
            #si el usuario actual es policia, mandar notificaccion al fiscal y alrevez para lo otro
            if current_user.police_unit.present?
              prosecutors = Prosecutor.not_deleted.where(local_prosecution_id: @procedure.local_prosecution_in_charge.id)
              prosecutors.each { |pros|
                Notification.create(user: pros.user, notification_type: 0, reference_id: @procedure.id, seen: false)
              }
            elsif current_user.prosecutor.present?
              @procedure.police_unit_in_charge.users.each { |police_user|
                Notification.create(user: police_user, notification_type: 0, reference_id: @procedure.id, seen: false)
              }
            end
          end

          format.html { redirect_to @procedure, notice: 'Procedimiento ha sido creado con éxito.' }
          format.json { render :show, status: :created, location: @procedure }
        else
          format.html { render :new }
          format.json { render json: @procedure.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /procedures/1
  # PATCH/PUT /procedures/1.json
  def update
    if params[:petition] == "update_borrador"
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

      dateOfArrest = Time.zone.local(d.year, d.month, d.day, t.hour, t.min, t.sec)

      respond_to do |format|
        if @procedure.update!(classification: classification_procedure,
                              police_in_charge: PoliceMan.find(procedure_params[:police_in_charge]),
                              police_unit_in_charge: PoliceUnit.find(procedure_params[:police_unit_in_charge]),
                              local_prosecution_in_charge: LocalProsecution.find(procedure_params[:prosecution_in_charge]),
                              story: procedure_params[:story],
                              address: procedure_params[:address],
                              sector: selected_sector,
                              region: selected_region,
                              state: params[:state].to_i,
                              date_of_arrest: dateOfArrest,
                              involves_deceased: procedure_params[:involves_deceased])


          if procedure_params[:deletedAccusseds] != nil
            if procedure_params[:deletedAccusseds].length() < @procedure.person_in_procedures.where(role: 0).length() + procedure_params[:accuseds].length()
              procedure_params[:deletedAccusseds].each do |accussed|
                personInProcedure = PersonInProcedure.find(accussed[:id])
                personInProcedure.destroy!
              end
            else
              @procedure.errors.add(:person_in_procedure, "se necesita al menos un imputado")
              format.json { render json: @procedure.errors, status: :unprocessable_entity }
              return
            end
          end

          if procedure_params[:deletedVictims] != nil
            procedure_params[:deletedVictims].each do |victim|
              personInProcedure = PersonInProcedure.find(victim[:id])
              personInProcedure.destroy!
            end
          end

          if procedure_params[:deletedWitnesses] != nil
            procedure_params[:deletedWitnesses].each do |witness|
              personInProcedure = PersonInProcedure.find(witness[:id])
              personInProcedure.destroy!
            end
          end

          if procedure_params[:deleted_photos] != nil
            procedure_params[:deleted_photos].each do |photo|
              photoInProcedure = Photo.find(photo)
              photoInProcedure.destroy!
            end
          end

          if procedure_params[:deleted_videos] != nil
            procedure_params[:deleted_videos].each do |video|
              videoInProcedure = Video.find(video)
              videoInProcedure.destroy!
            end
          end

          if procedure_params[:deleted_documents] != nil
            procedure_params[:deleted_documents].each do |doc|
              docInProcedure = Document.find(doc)
              docInProcedure.destroy!
            end
          end


          if procedure_params[:photos] != nil
            procedure_params[:photos].each_with_index do |photo,i|
              @photo = Photo.new(description: procedure_params[:photo_descriptions][i], procedure: @procedure)
              @photo.photo.attach(photo)
              @photo.save!
            end
          end

          if procedure_params[:videos] != nil
            procedure_params[:videos].each_with_index do |video,i|
              @video = Video.new(description: procedure_params[:video_descriptions][i], procedure: @procedure)
              @video.video.attach(video)
              @video.save!
            end
          end

          if procedure_params[:documents] != nil
            procedure_params[:documents].each_with_index do |document,i|
              @document = Document.new(description: procedure_params[:document_descriptions][i],name: procedure_params[:document_names][i], procedure: @procedure)
              @document.document.attach(document)
              @document.save!
            end
          end

          @procedure.taggings.destroy_all
          procedure_params[:tag_ids][1..procedure_params[:tag_ids].size].each do |tag|
            @tag = Tagging.new(tag: Tag.find_by_name(tag),
                               procedure: @procedure)
            @tag.save
          end

          #destruimos todos los crimenes, para asi crearlos denuevo y no tener problemas
          @procedure.crime_in_accuseds.destroy_all

          #si hay imputados nuevos
          if procedure_params[:accuseds]
            procedure_params[:accuseds].each do |accused|
              #los creamos
              @criminal = Person.new(name: accused[:name],
                                     rut: accused[:rut])
              if @criminal.save!
                #lo agregamos al procedimiento
                @criminal_in_procedure = PersonInProcedure.new(role: 0,
                                                               person: @criminal,
                                                               procedure: @procedure,
                                                               state: 0)
                @criminal_in_procedure.save
                @criminal_alias = AliasAccused.new(alias: accused[:alias],
                                                   person: @criminal)
                @criminal_alias.save
                #si hay crimenes nuevos
                if procedure_params[:crimes]
                  procedure_params[:crimes].each do |crime|
                    #se los agregamos al acusado
                    @crime_in_accused = CrimeInAccused.new(preponderant: false,
                                                           crime: Crime.find_by_name(crime),
                                                           person: @criminal,
                                                           procedure: @procedure)
                    @crime_in_accused.save
                  end
                end

                #le agregamos el delito preponderante al acusado
                @preponderan_crime_in_accused = CrimeInAccused.new(preponderant: true,
                                                                   crime: Crime.find_by_name(procedure_params[:preponderant_crime]),
                                                                   person: @criminal,
                                                                   procedure: @procedure)
                @preponderan_crime_in_accused.save
              end
            end
          end

          #si ya teniamos imputados
          if @procedure.person_in_procedures.where(role: 0)
            @procedure.person_in_procedures.where(role: 0).each do |criminal|
              #les agregamos el delito preponderante
              @preponderan_crime_in_accused = CrimeInAccused.new(preponderant: true,
                                                                 crime: Crime.find_by_name(procedure_params[:preponderant_crime]),
                                                                 person: criminal.person,
                                                                 procedure: @procedure)
              @preponderan_crime_in_accused.save

              #si hay delitos nuevos
              if procedure_params[:crimes]
                #le agregamos los delitos nuevos a los imputados existentes
                procedure_params[:crimes].each do |crime|
                  @crime_in_accused = CrimeInAccused.new(preponderant: false,
                                                         crime: Crime.find_by_name(crime),
                                                         person: criminal.person,
                                                         procedure: @procedure)
                  @crime_in_accused.save
                end
              end
            end
          end

          if procedure_params[:victims]
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
          end


          if procedure_params[:witness]
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
          end


          #mandar las notificaciones correspondientes
          if @procedure.state == "Open"
            #si el usuario actual es fiscal, mandar una notificacion de creacion al policia, sino mandarle al fiscal
            if current_user.prosecutor.present?
              @procedure.police_unit_in_charge.users.each { |police_user|
                Notification.create(user: police_user, notification_type: 0, reference_id: @procedure.id, seen: false)
              }
            elsif current_user.police_unit.present?
              prosecutors = Prosecutor.not_deleted.where(local_prosecution_id: @procedure.local_prosecution_in_charge.id)
              prosecutors.each { |pros|
                Notification.create(user: pros.user, notification_type: 0, reference_id: @procedure.id, seen: false)
              }
            end
          end

          format.html { redirect_to @procedure, notice: 'Procedimiento ha sido actualizado con éxito.' }
          format.json { render :show, status: :ok, location: @procedure }
        else
          format.json { render json: @procedure.errors, status: :unprocessable_entity }
        end
      end
    elsif params[:petition] == "change_state"
      respond_to do |format|
        $aux = @procedure.state
        if @procedure.update(state: params[:state])
          #If procedure was closed, notify the police unit
          if @procedure.state == "Close" && $aux == "Open"
            police_unit_id = @procedure.police_unit_in_charge.id
            police_unit_users = User.not_deleted.where(police_unit_id: police_unit_id)
            police_unit_users.each { |user|
              Notification.create(user_id: user.id, notification_type: 1, reference_id: @procedure.id, seen: false)
            }
          #Si el procedimiento pasa a estado borrador (se esta solicitando informacion)
          else
            #Crear mensaje con el contenido del text area del modal
            @message = Message.new(user_id: current_user.id, procedure_id: @procedure.id, content: params[:message])
            if @message.content.strip != ""
              @message.save
            end
            if @procedure.creator != current_user
              @procedure.police_unit_in_charge.users.each { |user|
                Notification.create(user_id: user.id, notification_type: 2, reference_id: @procedure.id, seen: false)
              }
            end
          end

          format.html { redirect_to procedures_path, notice: 'Procedimiento ha sido actualizado con éxito.' }
          format.json { render :show, status: :ok, location: @procedure }
        else
          format.json { render json: @procedure.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /procedures/1
  # DELETE /procedures/1.json
  def destroy
    @procedure.destroy
    respond_to do |format|
      format.html { redirect_to procedures_url, notice: 'Procedimiento ha sido eliminado con éxito.' }
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
    params.require(:procedure).permit(:date, :time, :classification, :involves_deceased, :prosecution_in_charge, :police_unit_in_charge, :police_in_charge, :address, :region, :sector, :preponderant_crime, :state, :story, crimes: [],
                                      videos: [],video_descriptions: [],deleted_videos: [], photos: [],photo_descriptions: [],deleted_photos: [], documents: [],document_names: [],document_descriptions: [],deleted_documents: [],
                                      tag_ids: [], :accuseds => [:name, :alias, :rut], :victims => [:name, :rut, :deceased, :contact, :story],
                                      :witness => [:name, :rut, :story, :contact], :deletedAccusseds => [:id], :deletedVictims => [:id], :deletedWitnesses => [:id], :deletedCrimes => [:id])
  end
end
