class AsientosContableController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_sidemenu, only: [:index]
  before_action :set_asiento_contable, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js
  def set_sidemenu
    @sidebar_layout = 'layouts/contabilidad_sidemenu'
  end
  def index
     #formatear las fechas
    if defined? params[:q][:fecha_lt]
      setupFechas
    end

    @search = AsientoContable.search(params[:q])
    @asientos_contable_size = @search.result.size
    if @search.sorts.empty?
      @asientos_contable = @search.result.order('numero').page(params[:page])
    else
      @asientos_contable = @search.result.page(params[:page])
    end
  end

  def imprimir_listado
    setupFechas
    @search = AsientoContable.search(params[:q])
    @asientos_contable = @search.result.order('numero')

  end

  def setupFechas
      #params[:q][:fecha_lt] = params[:q][:fecha_lt] + ' 23:59:59' unless params[:q][:fecha_lt].blank?
  end

  def update_list
    index
    render partial: 'update_list', format: 'js'
  end

  def show
    respond_to do |format|
      format.js { render 'show' }
    #   format.pdf { render :pdf => "factura_compra",
    #                       :layout => 'pdf.html',
    #                       :header => { :right => '[page] de [topage]',
    #                                     :left => "Impreso el  #{Formatter.format_date(DateTime.now)} por #{current_user.username}" }
    #               }
    end
  end

  def update
  end

  def edit

  end

  def set_asiento_contable
    @asiento_contable = AsientoContable.find(params[:id])
  end

  def asiento_contable_params
    params.require(:asiento_contable).permit(:numero, :fecha, :monto_total)
  end
end