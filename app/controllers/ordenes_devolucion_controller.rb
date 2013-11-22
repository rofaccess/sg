class OrdenesDevolucionController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_orden_devolucion, only: [:show, :edit, :update, :destroy]
  before_action :set_sidemenu, only: [:index]
  respond_to :html, :js, :pdf

  # GET /ordenes_devolucion
  # GET /ordenes_devolucion.json
  def set_sidemenu
    @sidebar_layout = 'layouts/compras_sidemenu'
  end

  def index
    #formatear las fechas
    if defined? params[:q][:fecha_generado_lt]
      setupFechas
    end

    @search = OrdenDevolucion.search(params[:q])
    @orden_devolucion = OrdenDevolucion.new
    @ordenes_devolucion_size = @search.result.size
    if @search.sorts.empty?
      @ordenes_devolucion = @search.result.order('fecha_generado').page(params[:page])
    else
      @ordenes_devolucion = @search.result.page(params[:page])
    end
  end

  def show
    @orden_devolucion = OrdenDevolucion.find(params[:id])

    respond_to do |format|
      format.js { render 'show' }
      format.pdf { render :pdf => "orden_devolucion",
                          :layout => 'pdf.html',
                          :header => { :right => '[page] de [topage]',
                                        :left => "Impreso el  #{Formatter.format_date(DateTime.now)} por #{current_user.username}" }
                  }
    end

  end

  def new
    @ordenes_compra = OrdenCompra.where(estado: 'Pendiente')
    @orden_devolucion = OrdenDevolucion.new
  end

  def setupFechas
      params[:q][:fecha_generado_lt] = params[:q][:fecha_generado_lt] + ' 23:59:59' unless params[:q][:fecha_generado_lt].blank?
      params[:q][:fecha_procesado_lt] = params[:q][:fecha_procesado_lt] + ' 23:59:59' unless params[:q][:fecha_procesado_lt].blank?


  end

  def edit
  end

  def create
    @search =OrdenCompra.search(params[:q])
    total_orden = 0
    total_iva = 0
    @orden_devolucion = OrdenDevolucion.new(orden_devolucion_params)
    ordenes_devolucion_detalle = @orden_devolucion.orden_devolucion_detalles
    ordenes_devolucion_detalle.each do |d|
      total_orden += d.costo_unitario * d.cantidad_devuelta

    end
    @orden_devolucion.total_orden = total_orden
    @orden_devolucion.total_iva = total_iva
    @orden_devolucion.fecha_generado = DateTime.now
    @orden_devolucion.save

    update_list

  end

  def destroy
    if @orden_devolucion.destroy
      redirect_to ordenes_devolucion_path, notice: t('messages.pedido_compra_deleted')
    else
      redirect_to ordenes_devolucion_path, alert: t('messages.pedido_compra_not_deleted')
    end
  end

  def get_orden_compra
    @orden_compra = OrdenCompra.find(params[:id])
    @orden_devolucion = OrdenDevolucion.new
    #@orden_devolucion.orden_devolucion_detalles.build
    render partial: 'get_orden_compra', formats: 'html'
  end

  def imprimir_listado
    setupFechas
    @search = OrdenDevolucion.search(params[:q])
    @ordenes_devolucion = @search.result.order('fecha_generado')

  end

  def update_list
    index
    render partial: 'update_list', format: 'js'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orden_devolucion
      @orden_devolucion = OrdenDevolucion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def orden_devolucion_params
      params.require(:orden_devolucion).permit(:numero, :numero_factura, :total_orden, :total_iva, :fecha_generado, :motivo, :orden_compra_id, :proveedor_id, :user_id,
        orden_devolucion_detalles_attributes: [:componente_id, :cantidad_devuelta, :costo_unitario, :iva, :motivo, :orden_compra_detalle_id])
    end

end
