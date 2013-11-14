class AsientosModeloController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_sidemenu, only: [:index]
  before_action :set_asiento_modelo, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js
  def set_sidemenu
    @sidebar_layout = 'layouts/contabilidad_sidemenu'
  end
  def index
    @search = AsientoModelo.search(params[:q])
    @asiento_modelo_size = @search.result.size
    if @search.sorts.empty?
      @asientos_modelo = @search.result.page(params[:page])
    else
      @asientos_modelo = @search.result.page(params[:page])
    end
  end

  # def imprimir_listado
  #   setupFechas
  #   @search = FacturaCompra.search(params[:q])
  #   @facturas_compra = @search.result.order('estado').order('fecha')

  # end

  # def new
  #   @ordenes_compra = OrdenCompra.where.not(estado: 'Facturado')
  # end

  # def get_orden_compra
  #   @orden_compra = OrdenCompra.find(params[:id])
  #   @factura_compra = FacturaCompra.new
  #   @factura_compra.factura_compra_detalles.build
  #   #@simbolo_moneda = Configuracion.find(1).simbolo_moneda
  #   render partial: 'get_orden_compra', formats: 'html'
  # end

  # def create
  #   @factura_compra = FacturaCompra.new(factura_compra_params)
  #   # Si la factura no tiene detalles entonces no se guarda
  #   if @factura_compra.factura_compra_detalles.blank?
  #     update_list
  #   else
  #     @orden_compra = OrdenCompra.find(@factura_compra.orden_compra_id)
  #     if @factura_compra.save
  #       # Actualiza cantidades recibidas en los detalles de la orden de compra
  #       @factura_compra.factura_compra_detalles.each do |d|
  #         orden_compra_detalle = OrdenCompraDetalle.find(d.orden_compra_detalle_id)
  #         cant = d.cantidad
  #         cant_actual = orden_compra_detalle.cantidad_recibida
  #         orden_compra_detalle.update(cantidad_recibida: (cant_actual + cant))
  #       end
  #       # Aca se actualiza el stock
  #       DepositoStock.actualizar_deposito_stock(@factura_compra.deposito_id, @factura_compra.id)
  #       # Cuando las cantidades recibidas y requeridas sean iguales el estado de la orden pasa a facturado
  #       if @orden_compra.orden_compra_detalles.sum('cantidad_recibida') == @orden_compra.orden_compra_detalles.sum('cantidad_requerida')
  #         @orden_compra.update(estado: PedidosEstados::FACTURADO, fecha_procesado: DateTime.now)
  #       else
  #         @orden_compra.update(estado: PedidosEstados::SEMIFACTURADO, fecha_procesado: DateTime.now)
  #       end
  #       if params[:from_orden_abm]
  #         redirect_to update_list_ordenes_compra_path(recargar_modal: true, orden_compra_id: @orden_compra.id)
  #       else
  #         update_list
  #       end
  #     end
  #   end
  # end

  def update_list
    index
    render partial: 'update_list', format: 'js'
  end

  def show
    respond_to do |format|
      format.js { render 'show' }
    #   format.pdf { render :pdf => "factura_compra",
    #                       :layout => 'pdf.html',
    #                       :header => { :right => '[page] de [topage]',
    #                                     :left => "Impreso el  #{Formatter.format_date(DateTime.now)} por #{current_user.username}" }
    #               }
    end
  end

  def update
    if @asiento_modelo.update(asiento_modelo_params)
      update_list
    else
      redirect_to componentes_path, alert: t('messages.marca_not_updated')
    end
  end

  def edit
  end

  # def destroy
  #   if @factura_compra.destroy
  #     redirect_to facturas_compra_path, notice: t('messages.pedido_compra_deleted')
  #   else
  #     redirect_to facturas_compra_path, alert: t('messages.pedido_compra_not_deleted')
  #   end
  # end

  def set_asiento_modelo
    @asiento_modelo = AsientoModelo.find(params[:id])
  end

  def asiento_modelo_params
      params.require(:asiento_modelo).permit(:concepto, :origen,
          asiento_modelo_detalles_attributes: [:cuenta_contable_id, :valor, :tipo_partida_doble, :asiento_modelo_id, :id])
  end
end
