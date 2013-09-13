class LocalidadesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_localidad, only: [:update, :destroy]
  before_action :set_sidemenu, only: [:index]
  before_action :nueva_localidad, only: [:crear_localidad]
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

  def crear_localidad
  	if @localidad.save
  	  flash.notice = "Se ha creado exitosamente la localidad #{@localidad.nombre}"
  	else
  	  flash.alert = "No ha creado la localidad #{@localidad.nombre}"
  	end
  end

  def update
  	if @localidad.update(localidad_params)

  	else

  	end
  end

  def destroy
  end

  def get_paises
  	@paises = Pais.all.order('nombre ASC')
  	render partial: 'lista_paises'
  end

  def get_estados
  	if params[:id].to_i == 0
  		@estados = Estado.all.order('nombre ASC')
  	else
  		pais = Pais.find(params[:id])
  		@estados = pais.estados.order('nombre ASC')
  	end
  	render partial: 'lista_estados'
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
