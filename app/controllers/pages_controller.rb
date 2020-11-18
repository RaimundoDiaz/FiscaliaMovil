class PagesController < ApplicationController

  def search
    @fin = []
    @palabras_clave = []
    if params[:palabras_clave] != nil and params[:palabras_clave] != ""
      print("PALABRA CLAVE")
      x = Procedure.where("story LIKE ? and local_prosecution_in_charge_id=?", "%"+params[:palabras_clave].to_s+"%", current_user.local_prosecution_id).pluck(:id)
      for i in x
        @palabras_clave.push(i)
      end
    end
    @query = []
    if params[:query] != nil and params[:query] != ""
      print("QUERY")
      x = Procedure.where("id = ? and local_prosecution_in_charge_id=?", params[:query].to_s, current_user.local_prosecution_id).pluck(:id)
      for i in x
        @query.push(i)
        redirect_to procedure_path(params[:query].to_s)
      end
    end
    @desde = []
    if params[:desde] != nil and params[:desde] != "" and params[:hasta] != nil and params[:hasta] != ""
      print("DESDE Y HASTA")
      x = Procedure.where("DATE(created_at) > ? AND DATE(created_at) < ? and local_prosecution_in_charge_id=?", params[:desde], params[:hasta], current_user.local_prosecution_id).pluck(:id)
      for i in x
        @desde.push(i)
      end
    elsif params[:desde] != nil and params[:desde] != ""
      print("DESDE")
      x = Procedure.where("DATE(date_of_arrest) > ? and local_prosecution_in_charge_id=?", params[:desde], current_user.local_prosecution_id).pluck(:id)
      for i in x
        @desde.push(i)
      end
    elsif params[:hasta] != nil and params[:hasta] != ""
      print("HASTA")
      x = Procedure.where("DATE(date_of_arrest) < ? and local_prosecution_in_charge_id=?", params[:hasta], current_user.local_prosecution_id).pluck(:id)
      for i in x
        @desde.push(i)
      end
    end

    @clasificacion = []
    if params[:classification] != nil and params[:classification] != ""
      print("CLASIFICAION: ", params[:classification] )
      case params[:classification]
      when "Flagrancia"
        x = Procedure.where("classification = 0 and local_prosecution_in_charge_id=?", current_user.local_prosecution_id).pluck(:id)
        for i in x
          @clasificacion.push(i)
        end
      when "ODP"
        x = Procedure.where("classification = 1 and local_prosecution_in_charge_id=?", current_user.local_prosecution_id).pluck(:id)
        for i in x
          @clasificacion.push(i)
        end
      when "Ambas"
        x = Procedure.where("classification = 2 and local_prosecution_in_charge_id=?", current_user.local_prosecution_id).pluck(:id)
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
        x = Procedure.where("involves_deceased = true and local_prosecution_in_charge_id=?", current_user.local_prosecution_id).pluck(:id)
        for i in x
          @involucra_fallecidos.push(i)
        end
      else
        x = Procedure.where("involves_deceased = false and local_prosecution_in_charge_id=?", current_user.local_prosecution_id).pluck(:id)
        for i in x
          @involucra_fallecidos.push(i)
        end
      end
    end

    @delito = []
    if params[:delito] != nil and params[:delito] != ""
      print("delito")
      x = Procedure.find(CrimeInAccused.where("crime_id = ?",Crime.where(name: params[:delito]).pluck(:id)).pluck(:procedure_id)).pluck(:id)
      yy = Procedure.where("local_prosecution_in_charge_id=?", current_user.local_prosecution_id).pluck(:id)
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
      yy = Procedure.where("local_prosecution_in_charge_id=?", current_user.local_prosecution_id).pluck(:id)
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
    else
      if params.key?("palabras_clave") or params.key?("query")
        @vieneDeHeader = true
      end
    end
  end

end
