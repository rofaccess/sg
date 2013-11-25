# -*- coding: utf-8 -*-
class OrdenesCompraController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_orden_compra, only: [:show, :edit, :update, :destroy]
  before_action :set_sidemenu, only: [:index]
  respond_to :html, :js, :pdf

  # GET /ordenes_compras
  # GET /ordenes_compras.json
  def set_sidemenu
    @sidebar_layout = 'layouts/compras_sidemenu'
  end

  def index
    #formatear las fechas
    if defined? params[:q][:fecha_generado_lt]
      setupFechas
    end
    @orden_compra = OrdenCompra.new
    resultados_ordenes(true)

  end

  def resultados_ordenes(paginate)
    @search = OrdenCompra.search(params[:q])
    if @search.sorts.empty?
      @ordenes_compra = @search.result.order('fecha_generado desc').order('estado')
    else
      @ordenes_compra = @search.result
    end

    if paginate
      @ordenes_compra = @ordenes_compra.page(params[:page])
      @ordenes_compra_size = @search.result.size
    end

  end

  # GET /ordenes_compras/1
  # GET /ordenes_compras/1.json
  def show
    @orden_compra = OrdenCompra.find(params[:id])
    #@ordenes_compra_detalle = OrdenCompraDetalle.where('orden_compra_id=?', @orden_compra)

    respond_to do |format|
      format.js { render 'show' }
      format.pdf { render :pdf => "orden_compra",
                          :layout => 'pdf.html',
                          :header => { :right => '[page] de [topage]',
                                        :left => "Impreso el  #{Formatter.format_date(DateTime.now)} por #{current_user.username}" }
                  }
    end

  end

  # GET /ordenes_compras/new
  def new
    @pedidos_compra = PedidoCompra.where(estado: PedidosEstados::PROCESADO)
    @orden_compra = OrdenCompra.new
  end

  def get_pedido_compra
    @pedido_compra = PedidoCompra.find(params[:id])
    if @pedido_compra.pedidos_cotizados.size > 0
      @mejores_precios = @pedido_compra.get_mejores_precios
    else
      @mejores_precios = nil
    end
    render partial: 'get_pedido_compra', formats: 'html'
  end

  def setupFechas
      params[:q][:fecha_generado_lt] = params[:q][:fecha_generado_lt] + ' 23:59:59' unless params[:q][:fecha_generado_lt].blank?
      params[:q][:fecha_procesado_lt] = params[:q][:fecha_procesado_lt] + ' 23:59:59' unless params[:q][:fecha_procesado_lt].blank?
  end

  # GET /ordenes_compras/1/edit
  def edit
  end

  # POST /ordenes_compras
  # POST /ordenes_compras.json
  def create
    @search =OrdenCompra.search(params[:q])
    @pedido_compra = PedidoCompra.find(params[:pedido_compra_id])
    mejores_precios = @pedido_compra.get_mejores_precios
    cotizaciones = @pedido_compra.pedido_cotizacions.where(estado: 'Cotizado')
    cotizaciones.each do |c|
      total = 0
      c.pedido_cotizacion_detalles.each do |d|
        if mejores_precios.include?(d.id)
          total += d.costo_unitario
        end
      end
      orden_compra = OrdenCompra.new( fecha_generado: DateTime.now,
                                              total_requerido: total,
                                              estado: PedidosEstados::PENDIENTE,
                                              user_id: current_user.id,
                                              proveedor_id: c.proveedor_id,
                                              pedido_cotizacion_id: c.id,
                                              pedido_compra_id: c.pedido_compra_id)

      c.pedido_cotizacion_detalles.each do |d|
        if mejores_precios.include?(d.id)
          orden_compra.orden_compra_detalles.build(componente_id: d.componente_id, costo_unitario: d.costo_unitario, cantidad_requerida: d.cantidad_cotizada, cantidad_recibida: 0)
        end
      end

      if orden_compra.orden_compra_detalles.size > 0
        orden_compra.save
      end
    end
    @pedido_compra.update(estado: PedidosEstados::ORDENADO, fecha_ordenado: DateTime.now)
  end

  def orden_personalizado
    @search =OrdenCompra.search(params[:q])
    @pedido_compra = PedidoCompra.find(params[:orden_compra][:pedido_compra_id])
    pedidos = params[:pedido_cotizacion]
    total_requerido = 0
    componentes = Array.new
    pedidos.each do |c, d|
      cotizacion = PedidoCotizacion.find(c)
      orden_compra = OrdenCompra.new( fecha_generado: DateTime.now,
                                      estado: PedidosEstados::PENDIENTE,
                                      user_id: current_user.id,
                                      proveedor_id: cotizacion.proveedor_id,
                                      pedido_cotizacion_id: cotizacion.id,
                                      pedido_compra_id: cotizacion.pedido_compra_id)

      d[:detalles].each do |i, v|
        detalle = PedidoCotizacionDetalle.find(v)
        orden_compra.orden_compra_detalles.build(componente_id: detalle.componente_id, costo_unitario: detalle.costo_unitario, cantidad_requerida: detalle.cantidad_cotizada)
        total_requerido += detalle.cantidad_cotizada*detalle.costo_unitario
        componentes.push(detalle.componente_id)
      end

      orden_compra.total_requerido = total_requerido

      if orden_compra.orden_compra_detalles.size > 0
        if orden_compra.save
          @pedido_compra.pedido_cotizacions.each do |c|
            c.update(estado: PedidosEstados::ORDENADO)
          end
        end
      end
    end
    @pedido_compra.update(estado: PedidosEstados::ORDENADO, fecha_ordenado: DateTime.now) if @pedido_compra.estado != PedidosEstados::ORDENADO

    # Actualiza el stock de los componentes incluidos en el pedido pero no en la orden
    @pedido_compra.pedido_compra_detalles.each do |d|
      if not componentes.include?(d.componente_id)
        deposito = DepositoStock.where("deposito_id = ? AND mercaderia_id = ?", @pedido_compra.deposito_id, d.componente_id).first
        deposito.update(pedido_generado: "No")
      end
    end
  end

  def destroy
    if @orden_compra.destroy
      flash.notice = "Se ha eliminado la orden de compra N˚ #{@orden_compra.numero}."
      index
    else
      flash.alert = "No se ha podido eliminar la orden de compra N˚ #{@orden_compra.numero}."
    end
  end


  def imprimir_listado
    if defined? params[:q][:fecha_generado_lt]
      setupFechas
    end
    resultados_ordenes(false)
    respond_to do |format|
      format.pdf { render :pdf => "orden_compra",
                          :layout => 'pdf.html',
                          :header => { :right => '[page] de [topage]',
                                        :left => "Impreso el  #{Formatter.format_date(DateTime.now)} por #{current_user.username}" }
                  }
    end
  end


  def update_list
    index
    render partial: 'update_list', format: 'js'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orden_compra
      @orden_compra = OrdenCompra.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def orden_compra_params
      params.require(:orden_compra).permit(:numero, :fecha_generado, :fecha_procesado, :total_requerido, :total_recibido, :estado, :user_id, :proveedor_id, :pedido_cotizacion_id)
    end
end
