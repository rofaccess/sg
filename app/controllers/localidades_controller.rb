class LocalidadesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_localidad, only: [:editar, :actualizar, :eliminar]
  before_action :set_sidemenu, only: [:index]
  before_action :nueva_localidad, only: [:crear]
  #load_and_authorize_resource
  respond_to :html, :js

  def set_sidemenu
    @sidebar_layout = 'layouts/configuraciones_sidemenu'
  end

  def index
  	@pais = Pais.new
  	@estado = Estado.new
  	@ciudad = Ciudad.new
  	@paises = Pais.all.order('nombre ASC')
  	@estados = Estado.all.order('nombre ASC')
  	@ciudades = Ciudad.all.order('nombre ASC')
  end

  def buscar_ciudades
    @ciudades = Ciudad.where('nombre LIKE ?', "%#{params[:term]}%")
    render json: @ciudades, only: [:nombre, :id] ,include: [estado:  {only: [:nombre], include: [pais: {only: [:nombre]}]}]
  end

  def crear
  	if @localidad.save
  	  flash.notice = "Se ha creado exitosamente la localidad #{@localidad.nombre}"
  	else
  	  flash.alert = "No ha creado la localidad #{@localidad.nombre}"
  	end
  end

  def editar
    if @tipo_localidad == 'pais'
 	    @pais = @localidad
 	    render partial: 'pais_form'
    elsif @tipo_localidad == 'estado'
      @paises = Pais.all.order('nombre ASC')
 	    @estado = @localidad
 	    render partial: 'estado_form'
 	  elsif @tipo_localidad == 'ciudad'
      @paises = Pais.all.order('nombre ASC')
      @estados = Estado.all.order('nombre ASC')
 	    @ciudad = @localidad
 	    render partial: 'ciudad_form'
    end
  end

  def actualizar
  	if @localidad.update(localidad_params)
  	  flash.notice = "Se ha actualizado exitosamente la localidad #{@localidad.nombre}"
  	else
  	  flash.alert = "No ha podido actualizar la localidad #{@localidad.nombre}"
  	end
  end

  def eliminar
  	if @localidad.destroy
  	  flash.notice = "Se ha eliminado exitosamente la localidad #{@localidad.nombre}"
  	else
  	  flash.alert = "No ha podido eliminar la localidad #{@localidad.nombre}"
  	end
  end

  def get_paises
    @paises = Pais.all.order('nombre ASC')

    unless params[:json] == 'true'
      render partial: 'lista_paises'
    else
      render json: @paises
    end

  end

  def get_estados
  	if params[:id].to_i == 0
  		@estados = Estado.all.order('nombre ASC')
  	else
  		pais = Pais.find(params[:id])
  		@estados = pais.estados.order('nombre ASC')
  	end

    unless params[:json]
      render partial: 'lista_estados'
    else
      render json: @estados.map { |e| [e.id, e.nombre] }
    end
  end

  def get_ciudades
  	if params[:id].to_i == 0
  		@ciudades = Ciudad.all.order('nombre ASC')
  	else
  		estado = Estado.find(params[:id])
  		@ciudades = estado.ciudades.order('nombre ASC')
  	end
  	render partial: 'lista_ciudades'
  end

  def nueva_localidad
  	tipo = get_tipo_localidad
  	@localidad = tipo.new(localidad_params)
  end

  def set_localidad
  	tipo = get_tipo_localidad
  	@localidad = tipo.find(params[:id])
  end

  def get_tipo_localidad
  	@tipo_localidad = params.require(:tipo_localidad)
  	@tipo_localidad.capitalize.constantize
  end

  def localidad_params
  	tipo = params.require(:tipo_localidad)
  	if tipo == 'pais'
  		params.require(:pais).permit(:nombre, :abreviatura)
  	elsif tipo == 'estado'
  		params.require(:estado).permit(:nombre, :abreviatura, :pais_id)
  	elsif tipo == 'ciudad'
  		params.require(:ciudad).permit(:nombre, :estado_id)
  	end
  end
end
