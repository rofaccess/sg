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
    @pedido_compra = PedidoCompra.find(params[:id])
    @pedidos_compra_detalle = PedidoCompraDetalle.where('pedido_compra_id=?', @pedido_compra)
  end

  def new
    @pedido_compra = PedidoCompra.new
  end

  def create_test_data
    estados = %w{ Pendiente Cotizado}
    @pedido_compra = PedidoCompra.new( numero: rand(10000), estado: estados[rand(estados.length)])
    @pedido_compra.save

    #componentes_categorias = %w{ Placa HDD Notebook}
    #@componente_categoria = ComponenteCategoria.new(nombre: componentes_categorias[rand(componentes_categorias.length)])
    #@componente_categoria.save

    #componentes = %w{ ATX-32MC AS-818 dv4-1234lt satellite-pro-5231}
    @componente = Componente.new( nombre: "ATX-32MC")
    @componente.save

    10.times do |num|
      @pedido_compra_detalle = PedidoCompraDetalle.new(pedido_compra_id: @pedido_compra.id,
                                                     componente_id: @componente.id,
                                                     cantidad: rand(10))
      @pedido_compra_detalle.save
    end
    if @pedido_compra_detalle.save
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
