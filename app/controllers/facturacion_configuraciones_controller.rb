class FacturacionConfiguracionesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_resource, only: [:editar, :actualizar, :eliminar]
  before_action :authorize, only: [:nuevo, :index, :crear, :editar, :actualizar, :eliminar]
  before_action :set_sidemenu, only: [:index]
  before_action :nuevo_resource, only: [:crear]
  respond_to :html, :js

  def authorize
    authorize! :manage, User
  end

  def set_sidemenu
    @sidebar_layout = 'layouts/configuraciones_sidemenu'
  end

  def index
  	@ivas = Iva.all
    @plazos = PlazoPago.all
  end

  def nuevo
    get_tipo_resource
    if @tipo_resource == 'iva'
      @iva = Iva.new
      @partial_form = 'iva_form'
    elsif @tipo_resource == 'plazo_pago'
      @plazo = PlazoPago.new
      @partial_form = 'plazo_pago_form'
    end
  end

  def crear
    get_resources

  	if @resource.save
  	  flash.notice = "Se ha creado exitosamente."
  	else
  	  flash.alert = "No ha creado."
  	end
  end

  def editar
    if @tipo_resource == 'iva'
 	    @iva = @resource
 	    @partial_form = 'iva_form'
    elsif @tipo_resource == 'plazo_pago'
      @plazo = @resource
 	    @partial_form = 'plazo_pago_form'
    end
    render 'nuevo'
  end

  def actualizar
    get_resources
  	if @resource.update(resource_params)
  	  flash.notice = "Se ha actualizado exitosamente."
  	else
  	  flash.alert = "No se ha podido actualizar."
  	end
    render 'crear'
  end

  def eliminar
    get_resources
  	if @resource.destroy
  	  flash.notice = "Se ha eliminado exitosamente"
  	else
  	  flash.alert = "No ha podido eliminar."
  	end
    render 'crear'
  end

  def nuevo_resource
  	tipo = get_tipo_resource
  	@resource = tipo.new(resource_params)
  end

  def get_resources
    if @tipo_resource == 'iva'
      @ivas = Iva.all
    elsif @tipo_resource == 'plazo_pago'
      @plazos = PlazoPago.all
    end
  end

  def set_resource
  	tipo = get_tipo_resource
  	@resource = tipo.find(params[:id])
  end

  def get_tipo_resource
  	@tipo_resource = params.require(:tipo_resource)
  	@tipo_resource.camelize.constantize
  end

  def resource_params
  	tipo = params.require(:tipo_resource)
  	if tipo == 'iva'
  		params.require(:iva).permit(:valor, :descripcion)
  	elsif tipo == 'plazo_pago'
  		params.require(:plazo_pago).permit(:nombre, :cuotas, :descripcion,
        plazo_pago_detalles_attributes: [:id, :cant_dias, :_destroy])
  	end
  end
end
