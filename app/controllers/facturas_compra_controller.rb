class FacturasCompraController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_sidemenu, only: [:index]
  before_action :set_factura_compra, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js
  def set_sidemenu
    @sidebar_layout = 'layouts/compras_sidemenu'
  end
  def index
    @search = FacturaCompra.search(params[:q])
    @factura_compra = FacturaCompra.new
    if @search.sorts.empty?
      @facturas_compra = @search.result.order('estado').page(params[:page]).per(10)
    else
      @facturas_compra = @search.result.page(params[:page]).per(10)
    end
  end

  def new
    @ordenes_compra = OrdenCompra.where(estado: 'Pendiente')
  end

  def get_orden_compra
    @orden_compra = OrdenCompra.find(params[:id])
    @factura_compra = FacturaCompra.new(proveedor_id: @orden_compra.proveedor_id)
    #@factura_compra_detalle = FacturaCompraDetalle.new(cantidad: 5)
    #@factura_compra.factura_compra_detalle_id = @factura_compra_detalle
    # @orden_compra.orden_compra_detalles.each do |o|
    #   @factura_compra.factura_compra_detalles(componente_id: o.componente_id,
    #                                           cantidad: o.cantidad_requerida,
    #                                           costo_unitario: o.costo_unitario)
    # end
    render partial: 'get_orden_compra', formats: 'html'
  end

  def create
  end

  def update
  end

  def edit
  end

  def set_factura_compra
    @factura_compra = FacturaCompra.find(params[:id])
  end

  def factura_compra_params
      params.require(:factura_compra).permit(:numero, :fecha_compra, :proveedor_id, :condicion_pago_id, :user_id, :estado, :orden_compra_id)
  end
end
