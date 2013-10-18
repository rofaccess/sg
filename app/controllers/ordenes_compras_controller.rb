class OrdenesComprasController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_orden_compra, only: [:show, :edit, :update, :destroy]
  before_action :set_sidemenu, only: [:index]
  respond_to :html, :js

  # GET /ordenes_compras
  # GET /ordenes_compras.json
  def set_sidemenu
    @sidebar_layout = 'layouts/compras_sidemenu'
  end


  def index
    @search = OrdenCompra.search(params[:q])
    @orden_compra = OrdenCompra.new
    if @search.sorts.empty?
      @ordenes_compras = @search.result.order('estado').page(params[:page]).per(8)
    else
      @ordenes_compras = @search.result.page(params[:page]).per(8)
    end
  end

  # GET /ordenes_compras/1
  # GET /ordenes_compras/1.json
  def show
    @orden_compra = OrdenCompra.find(params[:id])
    @ordenes_compra_detalle = OrdenCompraDetalle.where('orden_compra_id=?', @orden_compra)
  end

  # GET /ordenes_compras/new
  def new
    @pedidos_compra = PedidoCompra.where(estado: 'Procesado')
    @orden_compra = OrdenCompra.new
  end

  def get_pedido_compra
    @pedido_compra = PedidoCompra.find(params[:id])
    @mejores_precios = @pedido_compra.get_mejores_precios
    render partial: 'get_pedido_compra', formats: 'html'
  end

  # GET /ordenes_compras/1/edit
  def edit
  end

  # POST /ordenes_compras
  # POST /ordenes_compras.json
  def create
    pedidos = params[:pedido_cotizacion]
    pedidos.each do |id, val|
      puts "#{id} => #{val}"
      val[:detalles].each do |id_, val_|
        puts "#{id_} => #{val_}"

      end
    end
=begin
     @search = OrdenCompra.search(params[:q])
    @pedido_compra = PedidoCompra.find(params[:orden_compra][:pedido_compra_id])
   # @pedido_cotizacion = PedidoCotizacion.find(params[:orden_compra][:pedido_cotizacion_id])
   # categorias = @pedido_compra.get_componente_categorias
    cotizaciones = @pedido_compra.pedido_cotizacions.where(estado: 'Cotizado')
    #proveedores = ComponenteCategoria.get_proveedores(categorias)
    cotizaciones.each do |c|

      orden_compra = OrdenCompra.new( fecha: DateTime.now,
                                              costo_total: 0,
                                              estado: PedidosEstados::PENDIENTE,
                                              user_id: current_user.id,
                                              proveedor_id: c.proveedor_id,
                                              pedido_cotizacion_id: c.id,
                                              pedido_compra_id: c.pedido_compra_id)


      c.pedido_cotizacion_detalles.each do |d|
        orden_compra.orden_compra_detalles.build(componente_id: d.componente_id, costo_unitario: d.costo_unitario, cantidad_requerida: d.cantidad_cotizada)
      end
      orden_compra.save

    end

    @pedido_compra.update(estado: PedidosEstados::ORDENADO)

=end
  end

  def destroy
    if @orden_compra.destroy
      redirect_to ordenes_compras_path, notice: t('messages.pedido_compra_deleted')
    else
      redirect_to ordenes_compras_path, alert: t('messages.pedido_compra_not_deleted')
    end
  end



  def update_list
    index
    render partial: 'update_list', format: 'js'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orden_compra
      @orden_compra = OrdenCompra.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def orden_compra_params
      params.require(:orden_compra).permit(:numero, :fecha, :costo_total, :estado, :user_id, :proveedor_id, :pedido_cotizacion_id)
    end
end
