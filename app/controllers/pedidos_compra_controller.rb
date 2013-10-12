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

      if pedido_cotizacion.save
        @pedido_compra.update(estado: PedidosEstados::PROCESADO)
      end
    end
  end

  def create_test_data
    pedido_compra = PedidoCompra.new(estado: "Pendiente")

    Componente.all.each do |c|
      # por cada componente hay 10% de posibilidad de guardar un detalle
      if rand(100) < 10
        pedido_compra.pedido_compra_detalles.build(componente_id: c.id,
                                                   cantidad: rand(1..10))
      end
    end
    if  pedido_compra.save
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
      params.require(:pedido_compra).permit(:numero, :created_at, :estado, :user_id)
  end
end
