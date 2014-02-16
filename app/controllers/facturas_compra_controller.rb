# -*- coding: utf-8 -*-
class FacturasCompraController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_sidemenu, only: [:index]
  before_action :set_factura_compra, only: [:show, :edit, :update, :destroy, :imprimir_factura]
  respond_to :html, :js
  load_and_authorize_resource
  def set_sidemenu
    @sidebar_layout = 'layouts/compras_sidemenu'
  end
  def index
    #formatear las fechas
    if defined? params[:q][:fecha_lt]
      setupFechas
    end

    resultados_facturas(true)
  end

  def resultados_facturas(paginate)
    @search = FacturaCompra.search(params[:q])
    if @search.sorts.empty?
      @facturas_compra = @search.result.order('fecha desc').order('estado desc')
    else
      @facturas_compra = @search.result
    end

    if paginate
      @facturas_compra = @facturas_compra.page(params[:page])
      @facturas_compra_size = @search.result.size
    end
  end

  def imprimir_listado
    if defined? params[:q][:fecha_lt]
      setupFechas
    end
    resultados_facturas(false)
    respond_to do |format|
      format.pdf { render :pdf => "facturas",
                          :layout => 'pdf.html',
                          :header => { :right => '[page] de [topage]',
                                        :left => "Impreso el  #{Formatter.format_date(DateTime.now)} por #{current_user.username}" }
                  }
    end
  end

  def setupFechas
      params[:q][:fecha_lt] = params[:q][:fecha_lt] + ' 23:59:59' unless params[:q][:fecha_lt].blank?
  end

  def new
    @ordenes_compra = OrdenCompra.where.not(estado: PedidosEstados::FACTURADO)
  end

  def get_orden_compra
    @orden_compra = OrdenCompra.find(params[:id])
    @factura_compra = FacturaCompra.new
    @factura_compra.factura_compra_detalles.build
    render partial: 'get_orden_compra', formats: 'html'
  end

  def create
    @factura_compra = FacturaCompra.new(factura_compra_params)
    @orden_compra = OrdenCompra.find(@factura_compra.orden_compra_id)

    @factura_compra.save

    if(@factura_compra.condicion_pago.nombre == 'Credito')
      CompraCuentaCorriente.actualizar_cuenta_corriente(@factura_compra)
      AsientoContable.asentar_carga_factura_credito(@factura_compra)
    end

    actualizar_cantidad_orden_compra(@factura_compra)
    actualizar_estado_orden_compra(@orden_compra)

    if params[:from_orden_abm]
      redirect_to update_list_ordenes_compra_path(recargar_modal: true, orden_compra_id: @orden_compra.id)
    else
      flash.notice = "Se ha recibido la factura N˚ #{@factura_compra.numero}."
      update_list
    end
  end

  def actualizar_cantidad_orden_compra(factura_compra)
    factura_compra.factura_compra_detalles.each do |d|
      orden_compra_detalle = OrdenCompraDetalle.find(d.orden_compra_detalle_id)
      cant = d.cantidad
      cant_actual = orden_compra_detalle.cantidad_recibida
      orden_compra_detalle.update(cantidad_recibida: (cant_actual + cant))

      # Aca se actualiza el stock
      DepositoStock.actualizar_deposito_stock(factura_compra, d, orden_compra_detalle)
    end
  end

  def actualizar_estado_orden_compra(orden_compra)
    # Cuando las cantidades recibidas y requeridas sean iguales el estado de la orden pasa a facturado
      if orden_compra.orden_compra_detalles.sum('cantidad_recibida') == orden_compra.orden_compra_detalles.sum('cantidad_requerida')
        orden_compra.update(estado: PedidosEstados::FACTURADO, fecha_procesado: DateTime.now)
      else
        orden_compra.update(estado: PedidosEstados::SEMIFACTURADO, fecha_procesado: DateTime.now)
      end
  end

  def update_list
    index
    render partial: 'update_list', format: 'js'
  end

  def show
    respond_to do |format|
      format.js { render 'show' }
      format.pdf { render :pdf => "factura_compra",
                          :layout => 'pdf.html',
                          :header => { :right => '[page] de [topage]',
                                        :left => "Impreso el  #{Formatter.format_date(DateTime.now)} por #{current_user.username}" }
                  }
    end
  end

  def update
  end

  def edit
  end

  def destroy
    if @factura_compra.destroy
      flash.notice = "Se ha eliminado la factura de compra N˚ #{@factura_compra.numero}."
      index
    else
      flash.alert = "No se ha podido eliminar la factura de compra N˚ #{@factura_compra.numero}."
    end
  end

  def check_numero
    @factura_compra = FacturaCompra.where("numero = ? AND proveedor_id = ?", params[:factura_compra][:numero], params[:proveedor_id])
    if @factura_compra.blank?
      condition = true
    else
      condition = false
    end
    respond_to do |format|
      format.json { render :json => condition}
    end
  end

  def imprimir_factura

  end

  def set_factura_compra
    @factura_compra = FacturaCompra.find(params[:id])
  end

  def factura_compra_params
      params.require(:factura_compra).permit(:numero, :fecha, :total_iva, :total_factura, :proveedor_id, :condicion_pago_id, :plazo_pago_id, :user_id, :estado, :orden_compra_id,:deposito_id,
          factura_compra_detalles_attributes: [:componente_id, :cantidad, :costo_unitario, :iva_valor, :orden_compra_detalle_id])
  end
end
