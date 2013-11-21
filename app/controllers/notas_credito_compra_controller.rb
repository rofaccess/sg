class NotasCreditoCompraController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_sidemenu, only: [:index]
  before_action :set_nota_credito_compra, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js
  def set_sidemenu
    @sidebar_layout = 'layouts/compras_sidemenu'
  end
  def index
    #formatear las fechas
    if defined? params[:q][:fecha_lt]
      setupFechas
    end

    @search = NotaCreditoCompra.search(params[:q])
    @notas_credito_compra_size = @search.result.size
    if @search.sorts.empty?
      @notas_credito_compra = @search.result.order('fecha desc').page(params[:page])
    else
      @notas_credito_compra = @search.result.page(params[:page])
    end
  end

  def setupFechas
      params[:q][:fecha_lt] = params[:q][:fecha_lt] + ' 23:59:59' unless params[:q][:fecha_lt].blank?
  end

  def new
    @facturas_compra = FacturaCompra.all
  end

  def get_factura_compra
    @factura_compra = FacturaCompra.find(params[:id])
    @nota_credito_compra = NotaCreditoCompra.new
    @nota_credito_compra.nota_credito_compra_detalles.build
    render partial: 'get_factura_compra', formats: 'html'
  end

  def create
    @nota_credito_compra = NotaCreditoCompra.new(nota_credito_compra_params)
    #@factura_compra = FacturaCompra.find(@nota_credito_compra.factura_compra_id)

    #actualizar_cantidad_factura_compra(@nota_credito_compra)
    #actualizar_estado_factura_compra(@factura_compra)

    #if(@nota_credito_compra.condicion_pago.nombre == 'Credito')
    #  AsientoContable.asentar_carga_factura_credito(@nota_credito_compra)
    #end

    if @nota_credito_compra.save
      update_list
    end
  end

  def update_list
    index
    render partial: 'update_list', format: 'js'
  end

  def show
    respond_to do |format|
      format.js { render 'show' }
      format.pdf { render :pdf => "nota_credito_compra",
                          :layout => 'pdf.html',
                          :header => { :right => '[page] de [topage]',
                                        :left => "Impreso el  #{Formatter.format_date(DateTime.now)} por #{current_user.username}" }
                  }
    end
  end

  def update
  end

  def edit
  end

  def destroy
    if @nota_credito_compra.destroy
      redirect_to notas_credito_compra_path, notice: t('messages.pedido_compra_deleted')
    else
      redirect_to notas_credito_compra_path, alert: t('messages.pedido_compra_not_deleted')
    end
  end

  def check_numero
    @nota_credito_compra = NotaCreditoCompra.where("numero = ? AND proveedor_id = ?", params[:nota_credito_compra][:numero], params[:proveedor_id])
    if @nota_credito_compra.blank?
      condition = true
    else
      condition = false
    end
    respond_to do |format|
      format.json { render :json => condition}
    end
  end

  def set_nota_credito_compra
    @nota_credito_compra = NotaCreditoCompra.find(params[:id])
  end

  def nota_credito_compra_params
      params.require(:nota_credito_compra).permit(:numero, :fecha, :total, :proveedor_id, :user_id, :factura_compra_id,
          nota_credito_compra_detalles_attributes: [:componente_id, :cantidad, :costo_unitario, :factura_compra_detalle_id])
  end
end
