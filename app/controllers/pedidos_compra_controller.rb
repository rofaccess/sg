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
      @pedidos_compra = @search.result.order('estado desc').page(params[:page]).per(8)
    else
      @pedidos_compra = @search.result.page(params[:page]).per(8)
    end
  end

  def show
    @pedido_compra = PedidoCompra.find(params[:id])
    @pedidos_compra_detalle = PedidoCompraDetalle.where('pedido_compra_id=?', @pedido_compra)
  end

  def new
  end

  def create_pedido_cotizacion
    @pedido_compra = PedidoCompra.find(params[:id])
    categorias = @pedido_compra.get_componente_categorias
    proveedores = ComponenteCategoria.get_proveedores(categorias)

    # Se genera un pedido de cotizacion para cada proveedor
    proveedores.each do |p|
      proveedor = Proveedor.find(p)
      pedido_cotizacion = PedidoCotizacion.new( proveedor_id: p,
                                                pedido_compra_id: @pedido_compra.id,
                                                fecha_creacion: DateTime.now,
                                                estado: PedidosEstados::PENDIENTE,
                                                user_id: current_user.id)

      @pedido_compra.pedido_compra_detalles.each do |d|
        pedido_cotizacion.pedido_cotizacion_detalles.build(componente_id: d.componente_id, cantidad_requerida: d.cantidad) if proveedor.componente_categorias.exists?(d.componente.componente_categoria_id)
      end

      pedido_cotizacion.save
    end
    @pedido_compra.update(estado: PedidosEstados::COTIZADO)
    #if @pedido_compra.update(estado: PedidosEstados::COTIZADO)
    #  update_list
    #end

  end

  def create_test_data
    estados = %w{ Pendiente Cotizado}
    @pedido_compra = PedidoCompra.new( numero: rand(10000), estado: estados[rand(estados.length)])
    @pedido_compra.save

    @componentes = Componente.all

    10.times do |num|
      @componente = @componentes[rand(@componentes.length)]
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
