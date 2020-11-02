class PagesController < ApplicationController

  def search
    @palabras_clave = []
    if params[:palabras_clave] != nil and params[:palabras_clave] != ""
      x = Procedure.where("story LIKE ?", "%"+params[:palabras_clave].to_s+"%").pluck(:id)
      for i in x
        @palabras_clave.push(i)
      end
    end
    @desde = []
    if params[:desde] != nil and params[:desde] != "" and params[:hasta] != nil and params[:hasta] != ""
      x = Procedure.where("DATE(created_at) > ? AND DATE(created_at) < ?", params[:desde], params[:hasta]).pluck(:id)
      for i in x
        @palabras_clave.push(i)
      end
    elsif params[:desde] != nil and params[:desde] != ""
      x = Procedure.where("DATE(created_at) > ?", params[:desde]).pluck(:id)
      for i in x
        @palabras_clave.push(i)
      end
    elsif params[:hasta] != nil and params[:hasta] != ""
      x = Procedure.where("DATE(created_at) < ?", params[:hasta]).pluck(:id)
      for i in x
        @palabras_clave.push(i)
      end
    end


    if params[:classification] != nil and params[:classification] != ""
      case params[:classification]
      when "Flagrancia"
        x = Procedure.where("classification = 0").pluck(:id)
        for i in x
          @palabras_clave.push(i)
        end
      when "ODP"
        x = Procedure.where("classification = 1").pluck(:id)
        for i in x
          @palabras_clave.push(i)
        end
      when "Ambas"
        x = Procedure.where("classification = 2").pluck(:id)
        for i in x
          @palabras_clave.push(i)
        end
      end
    end


    if params[:involucra_fallecidos] != nil and params[:classification] != ""
      case params[:involucra_fallecidos]
      when "1"
        x = Procedure.where("involves_deceased = true").pluck(:id)
        for i in x
          @palabras_clave.push(i)
        end
      else
        x = Procedure.where("involves_deceased = false").pluck(:id)
        for i in x
          @palabras_clave.push(i)
        end
      end
    end


    if params[:delito] != nil and params[:delito] != ""
      x = Procedure.find(CrimeInAccused.where("crime_id = ?",Crime.where(name: params[:delito]).pluck(:id)).pluck(:procedure_id)).pluck(:id)
      for i in x
        @palabras_clave.push(i)
      end
    end

    #if params[:marca] != nil and params[:marca] != ""
    #  @query_buscada.push(Procedure.find(CrimeInAccused.where("crime_id = ?",Crime.where(name: params[:marca]).pluck(:id)).pluck(:procedure_id)))
    #end
    @palabras_clave = @palabras_clave.uniq
    @procedimientos_buscados = Procedure.find(@palabras_clave)
  end

end
