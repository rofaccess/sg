class PedidosCompraController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_pedido_compra, only: [:show, :update]
  before_action :set_sidemenu, only: [:index]

  def set_sidemenu
    @sidebar_layout = 'layouts/compras_sidemenu'
  end

  def index
  	@search = PedidoCompra.search(params[:q])
  	if @search.sorts.empty?
      @pedidos_compra = @search.result.order('id').page(params[:page]).per(8)
    else
      @pedidos_compra = @search.result.page(params[:page]).per(8)
    end
  end

  def show
  end

  def update
  end
  def set_pedido_compra
    @pedido_compra = PedidoCompra.find(params[:id])
  end
  def pedido_compra_params
      params.require(:pedido_compra).permit(:id, :numero, :fecha, :pendiente)
  end
end
