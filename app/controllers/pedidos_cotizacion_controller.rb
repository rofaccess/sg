# -*- coding: utf-8 -*-
class PedidosCotizacionController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_pedido_cotizacion, only: [:show, :edit, :update, :destroy, :imprimir_pedido]
  before_action :set_sidemenu, only: [:index]
  respond_to :html, :js
  authorize_resource

  def set_sidemenu
    @sidebar_layout = 'layouts/compras_sidemenu'
  end

  # GET /pedido_cotizacions
  # GET /pedido_cotizacions.json
  def index
    #formatear las fechas
    if defined? params[:q][:fecha_generado_lt]
      setupFechas
    end

    resultados_pedidos(true)
  end

  def resultados_pedidos(paginate)
    @search = PedidoCotizacion.search(params[:q])
    if @search.sorts.empty?
      @pedidos_cotizacion = @search.result.order('fecha_generado desc').order('estado asc')
    else
      @pedidos_cotizacion = @search.result
    end
    if paginate
      @pedidos_cotizacion_size = @search.result.size
      @pedidos_cotizacion = @pedidos_cotizacion.page(params[:page])
    end
  end

  def imprimir_listado
    #formatear las fechas
    if defined? params[:q][:fecha_generado_lt]
      setupFechas
    end
    resultados_pedidos(false)
    respond_to do |format|
      format.pdf { render :pdf => "pedidos_cotizaciones",
                          :layout => 'pdf.html',
                          :header => { :right => '[page] de [topage]',
                                        :left => "Impreso el  #{Formatter.format_date(DateTime.now)} por #{current_user.username}" }
                  }
    end
  end

  def setupFechas
    params[:q][:fecha_generado_lt] = params[:q][:fecha_generado_lt] + ' 23:59:59' unless params[:q][:fecha_generado_lt].blank?
    params[:q][:fecha_cotizado_lt] = params[:q][:fecha_cotizado_lt] + ' 23:59:59' unless params[:q][:fecha_cotizado_lt].blank?
  end

  # GET /pedido_cotizacions/1
  # GET /pedido_cotizacions/1.json
  def show
    respond_to do |format|
      format.js  {render 'show'}
      format.pdf { render :pdf => "pedido_cotizacion",
                          :layout => 'pdf.html',
                          :header => { :right => '[page] de [topage]',
                                        :left => "Impreso el  #{Formatter.format_date(DateTime.now)} por #{current_user.username}" }
                  }
    end
  end

  # GET /pedido_cotizacions/new
  def new
    @pedidos_compra = PedidoCompra.where(estado: PedidosEstados::PENDIENTE)
    @pedido_cotizacion = PedidoCotizacion.new
  end

  def get_pedido_compra
    @pedido_compra = PedidoCompra.find(params[:id])
    render partial: 'get_pedido_compra', formats: 'html'
  end

  # GET /pedido_cotizacions/1/edit
  def edit
  end

  # POST /pedido_cotizacions
  # POST /pedido_cotizacions.json
  def create
    pedidos_compra = params[:pedidos_compra_ids]
    pedidos_cotizaciones_count = 0
    pedidos_compra.each do |pedido_id|
      @pedido_compra = PedidoCompra.find(pedido_id)
      categorias = @pedido_compra.get_componente_categorias
      proveedores = ComponenteCategoria.get_proveedores(categorias)

      # Se genera un pedido de cotizacion para cada proveedor
      proveedores.each do |p|
        proveedor = Proveedor.find(p)
        pedido_cotizacion = PedidoCotizacion.new( proveedor_id: p,
                                                  pedido_compra_id: @pedido_compra.id,
                                                  fecha_generado: DateTime.now,
                                                  estado: PedidosEstados::PENDIENTE,
                                                  user_id: current_user.id)

        @pedido_compra.pedido_compra_detalles.each do |d|
          pedido_cotizacion.pedido_cotizacion_detalles.build(componente_id: d.componente_id, cantidad_requerida: d.cantidad, pedido_compra_detalle_id: d.id) if proveedor.componente_categorias.exists?(d.componente.componente_categoria_id)
        end

        pedido_cotizacion.save
        pedidos_cotizaciones_count +=1
      end

      @pedido_compra.update(estado: PedidosEstados::PROCESADO, fecha_procesado: DateTime.now) if @pedido_compra.estado != PedidosEstados::PROCESADO

    end
    flash.notice = "Se ha generado #{pedidos_cotizaciones_count} pedidos de cotizaciones."
  end

  # PATCH/PUT /pedido_cotizacions/1
  # PATCH/PUT /pedido_cotizacions/1.json
  def update
    # Evitar que se cambie el estado si todos los precios son 0
    precios_actualizados = false
    pedido_cotizacion_params[:pedido_cotizacion_detalles_attributes].each do |d|
      unless precios_actualizados
        precios_actualizados = true if d[1]['costo_unitario'].to_i > 0
      end
    end

    if @pedido_cotizacion.estado == PedidosEstados::PENDIENTE && precios_actualizados
      @pedido_cotizacion.estado = PedidosEstados::COTIZADO
      @pedido_cotizacion.fecha_cotizado = DateTime.now
    end
    if @pedido_cotizacion.update(pedido_cotizacion_params)
      CustomLogging.create(item_type: 'PedidoCotizacion', item_id: @pedido_cotizacion.id, event: 'update', whodunnit: current_user.id, object: YAML::dump(@pedido_cotizacion.attributes), created_at: DateTime.now)

      flash.notice = "Se ha actualizado los datos del pedido de cotizacion N˚ #{@pedido_cotizacion.numero}."
      index
    else
      flash.alert = "No se ha actualizado los datos del pedido de cotizacion N˚ #{@pedido_cotizacion.numero}."
    end
  end

  # DELETE /pedido_cotizacions/1
  # DELETE /pedido_cotizacions/1.json
  def destroy
    if @pedido_cotizacion.destroy
      flash.notice = "Se ha eliminado el pedido de cotizacion N˚ #{@pedido_cotizacion.numero}."
      index
    else
      flash.alert = "No se ha podido eliminar el pedido de cotizacion N˚ #{@pedido_cotizacion.numero}."
    end
  end

  def imprimir_pedido

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pedido_cotizacion
      @pedido_cotizacion = PedidoCotizacion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pedido_cotizacion_params
      params.require(:pedido_cotizacion).permit(:numero, :proveedor_id, :estado, :fecha_generado, :fecha_cotizado, :user_id, :pedido_compra_id,
        pedido_cotizacion_detalles_attributes: [:id, :cantidad_cotizada, :costo_unitario])
    end
end
