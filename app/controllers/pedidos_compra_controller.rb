class PedidosCompraController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_pedido_compra, only: [:show, :update, :destroy]
  before_action :set_sidemenu, only: [:index]
  respond_to :html, :js

  def set_sidemenu
    @sidebar_layout = 'layouts/compras_sidemenu'
  end

  def index
  	@search = PedidoCompra.search(params[:q])
    @pedido_compra = PedidoCompra.new
  	if @search.sorts.empty?
      @pedidos_compra = @search.result.order('estado').page(params[:page]).per(8)
    else
      @pedidos_compra = @search.result.page(params[:page]).per(8)
    end
  end

  def show

  end

  def new
    @pedido_compra = PedidoCompra.new
  end

  def create_test_data
    estados = %w{ Pendiente Cotizado}
    estado = estados[rand(estados.length)]

    @pedido_compra = PedidoCompra.new( numero: rand(10000), estado: estado)

    if @pedido_compra.save
      update_list
    else
      redirect_to pedidos_compra_path, alert: t('messages.pedido_compra_not_saved')
    end
  end

  def update_list
    index
    render partial: 'update_list', format: 'js'
  end

  def update

  end
  def destroy
    if @pedido_compra.destroy
      redirect_to pedidos_compra_path, notice: t('messages.pedido_compra_deleted')
    else
      redirect_to pedidos_compra_path, alert: t('messages.pedido_compra_not_deleted')
    end
  end

  def set_pedido_compra
    @pedido_compra = PedidoCompra.find(params[:id])
  end
  def pedido_compra_params
      params.require(:pedido_compra).permit(:numero, :created_at, :estado)
  end
end
