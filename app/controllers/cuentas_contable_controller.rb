class CuentasContableController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_sidemenu, only: [:index]
  before_action :set_cuenta_contable, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js
  def set_sidemenu
    @sidebar_layout = 'layouts/contabilidad_sidemenu'
  end
  def index
    @search = CuentaContable.search(params[:q])
    @cuentas_contable_size = @search.result.size
    if @search.sorts.empty?
      @cuentas_contable = @search.result.order('codigo').page(params[:page])
    else
      @cuentas_contable = @search.result.page(params[:page])
    end
  end

  def imprimir_listado
    @search = CuentaContable.search(params[:q])
    @cuentas_contable = @search.result.order('codigo')

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
    @cuenta_contable = CuentaContable.find(params[:id])
  end

  def asiento_contable_params
    #params.require(:cuenta_contable).permit(:numero, :fecha, :monto_total)
  end
end
