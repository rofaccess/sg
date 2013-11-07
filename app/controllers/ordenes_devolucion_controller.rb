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
    @facturas_compra = FacturaCompra.where(estado: 'Procesado')
    @orden_devolucion = OrdenDevolucion.new
  end

  def setupFechas
      params[:q][:fecha_generado_lt] = params[:q][:fecha_generado_lt] + ' 23:59:59' unless params[:q][:fecha_generado_lt].blank?
      params[:q][:fecha_procesado_lt] = params[:q][:fecha_procesado_lt] + ' 23:59:59' unless params[:q][:fecha_procesado_lt].blank?


  end

  def edit
  end

  def create

  end

  def destroy
    if @orden_devolucion.destroy
      redirect_to ordenes_devolucion_path, notice: t('messages.pedido_compra_deleted')
    else
      redirect_to ordenes_devolucion_path, alert: t('messages.pedido_compra_not_deleted')
    end
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
      params.require(:orden_devolucion).permit(:numero, :total_orden, :total_iva, :fecha_generado, :motivo, :factura_compra_id, :proveedor_id, :user_id)
    end

end