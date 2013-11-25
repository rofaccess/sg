class PedidosCompraController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_pedido_compra, only: [:show, :update, :destroy]
  before_action :set_sidemenu, only: [:index]
  respond_to :html, :js

  def set_sidemenu
    @sidebar_layout = 'layouts/compras_sidemenu'
  end

  def index
    #formatear las fechas
    if defined? params[:q][:fecha_generado_lt]
      params[:q][:fecha_generado_lt] = params[:q][:fecha_generado_lt] + ' 23:59:59' unless params[:q][:fecha_generado_lt].blank?
      params[:q][:fecha_procesado_lt] = params[:q][:fecha_procesado_lt] + ' 23:59:59' unless params[:q][:fecha_procesado_lt].blank?
      params[:q][:fecha_ordenado_lt] = params[:q][:fecha_ordenado_lt] + ' 23:59:59' unless params[:q][:fecha_ordenado_lt].blank?
    end

   	@search = PedidoCompra.search(params[:q])
    @pedido_compra = PedidoCompra.new
    @pedidos_compra_size = @search.result.size
    if @search.sorts.empty?
      @pedidos_compra = @search.result.order('fecha_generado desc').page(params[:page])
    else
      @pedidos_compra = @search.result.page(params[:page])
    end
  end

  def show
    @pedido_compra = PedidoCompra.find(params[:id])

    if @pedido_compra.estado == PedidosEstados::PROCESADO
      @pedidos_cotizacion = PedidoCotizacion.where(pedido_compra_id: @pedido_compra.id)
    end

    if @pedido_compra.estado == PedidosEstados::ORDENADO
      @pedidos_cotizacion = PedidoCotizacion.where(pedido_compra_id: @pedido_compra.id)
      @ordenes_compra = OrdenCompra.where(pedido_compra_id: @pedido_compra.id)
    end
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
                                                fecha_generado: DateTime.now,
                                                estado: PedidosEstados::PENDIENTE,
                                                user_id: current_user.id)

      @pedido_compra.pedido_compra_detalles.each do |d|
        pedido_cotizacion.pedido_cotizacion_detalles.build(componente_id: d.componente_id, cantidad_requerida: d.cantidad, pedido_compra_detalle_id: d.id) if proveedor.componente_categorias.exists?(d.componente.componente_categoria_id)
      end

      if pedido_cotizacion.save
        @pedido_compra.update(estado: PedidosEstados::PROCESADO, fecha_procesado: DateTime.now) if @pedido_compra.estado != PedidosEstados::PROCESADO
        @pedidos_cotizacion = PedidoCotizacion.where(pedido_compra_id: @pedido_compra.id)
      end
    end
  end

  def imprimir_listado
    @search = PedidoCompra.search(params[:q])

    @pedidos_compra = @search.result.order('fecha_generado').order('estado')

  end

  def create_test_data
    # Crea un pedido por cada deposito
    pedidos = 0
    DepositoMateriaPrima.all.each do |d|
      pedido_compra = PedidoCompra.new(estado: "Pendiente", fecha_generado: DateTime.now, deposito_id: d.id)
      d.deposito_stocks.each do |d_s|
        ex = d_s.existencia
        min = d_s.existencia_min
        max = d_s.existencia_max
        if (d_s.pedido_generado == "No") && (ex < min)
          pedido_compra.pedido_compra_detalles.new( componente_id: d_s.mercaderia_id,
                                                    cantidad: max - ex)
          d_s.update(pedido_generado: "Si")
        end
      end
      unless pedido_compra.pedido_compra_detalles.blank?
        pedido_compra.save
        pedidos +=1
      end
    end
    flash.notice = pedidos == 0 ? "No hay componentes que necesiten reponerse" : "Se han generado #{pedidos} pedidos de compra"
    update_list
  end

  def update_list
    index
    render partial: 'update_list', format: 'js'
  end

  def destroy
    # Si se elimina un pedido pendiente, los componentes de sus detalles en el deposito se liberan para poderse crear de nuevo el pedido
    @pedido_compra.pedido_compra_detalles.each do |d|
      stock = DepositoStock.where("deposito_id = ? AND mercaderia_id = ?", @pedido_compra.deposito_id, d.componente_id).first
      if not stock.blank?
        stock.update(pedido_generado: 'No')
      end
    end
    if @pedido_compra.destroy
      flash.notice = "Se ha eliminado el pedido de compra N˚ #{@pedido_compra.numero}."
      index
    else
      flash.alert = "No se ha podido eliminar el pedido de compra N˚ #{@pedido_compra.numero}."
    end
  end

  def set_pedido_compra
    @pedido_compra = PedidoCompra.find(params[:id])
  end
  def pedido_compra_params
      params.require(:pedido_compra).permit(:numero, :fecha_generado, :fecha_procesado, :fecha_ordenado, :estado, :user_id)
  end
end
