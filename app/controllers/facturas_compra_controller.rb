class FacturasCompraController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_sidemenu, only: [:index]
  before_action :set_factura_compra, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js
  def set_sidemenu
    @sidebar_layout = 'layouts/compras_sidemenu'
  end
  def index
    @facturas_compra = FacturaCompra.all
  end

  def new
  end

  def create
  end

  def update
  end

  def edit
  end

  def factura_compra_params
      params.require(:factura_compra).permit(:numero, :fecha_compra, :proveedor_id, :condicion_pago_id, :user_id, :estado)
  end
end
