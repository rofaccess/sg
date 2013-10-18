class FacturasCompraController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_sidemenu, only: [:index]
  before_action :set_factura_compra, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js
  def set_sidemenu
    @sidebar_layout = 'layouts/compras_sidemenu'
  end
  def index
    #@search = FacturaCompra.search(params[:q])
    #@factura_compra = FacturaCompra.new
    #if @search.sorts.empty?
    #  @facturas_compra = @search.result.order('estado').page(params[:page]).per(10)
    #else
    #  @facturas_compra = @search.result.page(params[:page]).per(10)
    #end
    @facturas_compra = FacturaCompra.filtrar(params[:orden_compra_id]).page(params[:page]).per(10)
  end

  def new
    @ordenes_compra = OrdenCompra.where.not(estado: 'Procesado')
  end

  def get_orden_compra
    @orden_compra = OrdenCompra.find(params[:id])
    @factura_compra = FacturaCompra.new
    @factura_compra.factura_compra_detalles.build
    render partial: 'get_orden_compra', formats: 'html'
  end

  def create
    @factura_compra = FacturaCompra.new(factura_compra_params)
    if @factura_compra.save
      update_list
    end
  end

  def update_list
    index
    render partial: 'update_list', format: 'js'
  end

  def show

  end

  def update
  end

  def edit
  end

  def destroy
    if @factura_compra.destroy
      redirect_to facturas_compra_path, notice: t('messages.pedido_compra_deleted')
    else
      redirect_to facturas_compra_path, alert: t('messages.pedido_compra_not_deleted')
    end
  end

  def set_factura_compra
    @factura_compra = FacturaCompra.find(params[:id])
  end

  def factura_compra_params
      params.require(:factura_compra).permit(:numero, :fecha_compra,:fecha_vencimiento, :total_iva, :total_factura, :proveedor_id, :condicion_pago_id, :plazo_pago_id, :user_id, :estado, :orden_compra_id,
          factura_compra_detalles_attributes: [:iva_porcentaje, :componente_id, :cantidad, :costo_unitario, :iva_unitario, :total])
  end
end
