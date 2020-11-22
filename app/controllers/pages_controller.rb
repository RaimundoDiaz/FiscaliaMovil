class PagesController < ApplicationController

  def search
    @fin = []
    @palabras_clave = []
    if params[:palabras_clave] != nil and params[:palabras_clave] != ""
      print("PALABRA CLAVE")
      if current_user.prosecutor.present?
        x = Procedure.where("story LIKE ? and local_prosecution_in_charge_id=?", "%"+params[:palabras_clave].to_s+"%", current_user.prosecutor.local_prosecution_id).pluck(:id)
      elsif current_user.police_unit.present?
        x = Procedure.where("story LIKE ? and police_unit_in_charge_id=?", "%"+params[:palabras_clave].to_s+"%", current_user.police_unit_id).pluck(:id)
      elsif current_user.admin?
        x = Procedure.where("story LIKE ?", "%"+params[:palabras_clave].to_s).pluck(:id)
      end
      for i in x
        @palabras_clave.push(i)
      end
    end
    @query = []
    if params[:query] != nil and params[:query] != ""
      print("QUERY")
      if params[:query].to_i.to_s == params[:query]
        if current_user.prosecutor.present?
          x = Procedure.where("id = ? and local_prosecution_in_charge_id=?", params[:query].to_s, current_user.prosecutor.local_prosecution_id).pluck(:id)
        elsif current_user.police_unit.present?
          x = Procedure.where("id = ? and police_unit_in_charge_id=?", params[:query].to_s, current_user.police_unit_id).pluck(:id)
        elsif current_user.admin?
          x = Procedure.where("id = ?", params[:query].to_s).pluck(:id)
        end
        for i in x
          @query.push(i)
          redirect_to procedure_path(params[:query].to_s)
        end
      end
    end
    @desde = []
    if params[:desde] != nil and params[:desde] != "" and params[:hasta] != nil and params[:hasta] != ""
      print("DESDE Y HASTA")
      if current_user.prosecutor.present?
        x = Procedure.where("DATE(created_at) > ? AND DATE(created_at) < ? and local_prosecution_in_charge_id=?", params[:desde], params[:hasta], current_user.prosecutor.local_prosecution_id).pluck(:id)
      elsif current_user.police_unit.present?
        x = Procedure.where("DATE(created_at) > ? AND DATE(created_at) < ? and police_unit_in_charge_id=?", params[:desde], params[:hasta], current_user.police_unit_id).pluck(:id)
      elsif current_user.admin?
        x = Procedure.where("DATE(created_at) > ? AND DATE(created_at) < ?", params[:desde], params[:hasta]).pluck(:id)
      end
      for i in x
        @desde.push(i)
      end
    elsif params[:desde] != nil and params[:desde] != ""
      print("DESDE")
      if current_user.prosecutor.present?
        x = Procedure.where("DATE(date_of_arrest) > ? and local_prosecution_in_charge_id=?", params[:desde], current_user.prosecutor.local_prosecution_id).pluck(:id)
      elsif current_user.police_unit.present?
        x = Procedure.where("DATE(date_of_arrest) > ? and police_unit_in_charge_id=?", params[:desde], current_user.police_unit_id).pluck(:id)
      elsif current_user.admin?
        x = Procedure.where("DATE(date_of_arrest) > ?", params[:desde]).pluck(:id)
      end
      for i in x
        @desde.push(i)
      end
    elsif params[:hasta] != nil and params[:hasta] != ""
      print("HASTA")
      if current_user.prosecutor.present?
        x = Procedure.where("DATE(date_of_arrest) < ? and local_prosecution_in_charge_id=?", params[:hasta], current_user.prosecutor.local_prosecution_id).pluck(:id)
      elsif current_user.police_unit.present?
        x = Procedure.where("DATE(date_of_arrest) < ? and police_unit_in_charge_id=?", params[:hasta], current_user.police_unit_id).pluck(:id)
      elsif current_user.admin?
        x = Procedure.where("DATE(date_of_arrest) < ?", params[:hasta]).pluck(:id)
      end
      for i in x
        @desde.push(i)
      end
    end

    @clasificacion = []
    if params[:classification] != nil and params[:classification] != ""
      print("CLASIFICAION: ", params[:classification] )
      case params[:classification]
      when "Flagrancia"
        if current_user.prosecutor.present?
          x = Procedure.where("classification = 0 and local_prosecution_in_charge_id=?", current_user.prosecutor.local_prosecution_id).pluck(:id)
        elsif current_user.police_unit.present?
          x = Procedure.where("classification = 0 and police_unit_in_charge_id=?", current_user.police_unit_id).pluck(:id)
        elsif current_user.admin?
          x = Procedure.where("classification = 0").pluck(:id)
        end
        for i in x
          @clasificacion.push(i)
        end
      when "ODP"
        if current_user.prosecutor.present?
          x = Procedure.where("classification = 1 and local_prosecution_in_charge_id=?", current_user.prosecutor.local_prosecution_id).pluck(:id)
        elsif current_user.police_unit.present?
          x = Procedure.where("classification = 1 and police_unit_in_charge_id=?", current_user.police_unit_id).pluck(:id)
        elsif current_user.admin?
          x = Procedure.where("classification = 1").pluck(:id)
        end
        for i in x
          @clasificacion.push(i)
        end
      when "Ambas"
        if current_user.prosecutor.present?
          x = Procedure.where("classification = 2 and local_prosecution_in_charge_id=?", current_user.prosecutor.local_prosecution_id).pluck(:id)
        elsif current_user.police_unit.present?
          x = Procedure.where("classification = 2 and police_unit_in_charge_id=?", current_user.police_unit_id).pluck(:id)
        elsif current_user.admin?
          x = Procedure.where("classification = 2").pluck(:id)
        end
        for i in x
          @clasificacion.push(i)
        end
      end
    end

    @involucra_fallecidos = []
    if params[:involucra_fallecidos] != nil and params[:involucra_fallecidos] != ""
      print("involucra_fallecidos")
      case params[:involucra_fallecidos]
      when "Si"
        if current_user.prosecutor.present?
          x = Procedure.where("involves_deceased = true and local_prosecution_in_charge_id=?", current_user.prosecutor.local_prosecution_id).pluck(:id)
        elsif current_user.police_unit.present?
          x = Procedure.where("involves_deceased = true and police_unit_in_charge_id=?", current_user.police_unit_id).pluck(:id)
        elsif current_user.admin?
          x = Procedure.where("involves_deceased = true").pluck(:id)
        end
        for i in x
          @involucra_fallecidos.push(i)
        end
      else
        if current_user.prosecutor.present?
          x = Procedure.where("involves_deceased = false and local_prosecution_in_charge_id=?", current_user.prosecutor.local_prosecution_id).pluck(:id)
        elsif current_user.police_unit.present?
          x = Procedure.where("involves_deceased = false and police_unit_in_charge_id=?", current_user.police_unit_id).pluck(:id)
        elsif current_user.admin?
          x = Procedure.where("involves_deceased = false").pluck(:id)
        end
        for i in x
          @involucra_fallecidos.push(i)
        end
      end
    end

    @delito = []
    if params[:delito] != nil and params[:delito] != ""
      print("Delito")
      x = Procedure.find(CrimeInAccused.where("crime_id = ?",Crime.where(name: params[:delito]).pluck(:id)).pluck(:procedure_id)).pluck(:id)
      if current_user.prosecutor.present?
        yy = Procedure.where("local_prosecution_in_charge_id=?", current_user.prosecutor.local_prosecution_id).pluck(:id)
      elsif current_user.police_unit.present?
        yy = Procedure.where("police_unit_in_charge_id=?", current_user.police_unit_id).pluck(:id)
      elsif current_user.admin?
        yy = Procedure.all.pluck(:id)
      end
      x = x & yy
      for i in x
        @delito.push(i)
      end
    end

    @marcas = []
    if params[:tag_ids] != nil and params[:tag_ids] != ""
      for tag_name in params[:tag_ids][1..params[:tag_ids].size]
        @marcas.push(Procedure.find(Tagging.where("tag_id = ?",Tag.where("name = ?", tag_name).pluck(:id)).pluck(:procedure_id)).pluck(:id))
      end
      x = []
      for i in @marcas
        for w in i
          x.push(w)
        end
      end
      if current_user.prosecutor.present?
        yy = Procedure.where("local_prosecution_in_charge_id=?", current_user.prosecutor.local_prosecution_id).pluck(:id)
      elsif current_user.police_unit.present?
        yy = Procedure.where("police_unit_in_charge_id=?", current_user.police_unit_id).pluck(:id)
      elsif current_user.admin?
        yy = Procedure.all.pluck(:id)
      end
      @marcas = x & yy

    end

    for i in [@query, @palabras_clave, @desde, @clasificacion, @involucra_fallecidos, @delito, @marcas]
      if i != []
        if @palabras_clave == []
          @palabras_clave = i
        end
        if @desde == []
          @desde = i
        end
        if @clasificacion == []
          @clasificacion = i
        end
        if @involucra_fallecidos == []
          @involucra_fallecidos = i
        end
        if @delito == []
          @delito = i
        end
        if @query == []
          @query = i
        end
        if @marcas == []
          @marcas = i
        end
        break
      end
    end
    @fin = @palabras_clave & @desde & @clasificacion & @involucra_fallecidos & @delito & @query & @marcas
    if @fin != []
      @vieneDeHeader = false
      @procedimientos_buscados = Procedure.find(@fin)
      @procedimientos_buscados = @procedimientos_buscados.sort_by &:created_at
    else
      if params.key?("palabras_clave") or params.key?("query")
        @vieneDeHeader = true
      end
    end
  end

end
