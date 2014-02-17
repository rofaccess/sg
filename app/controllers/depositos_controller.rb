class DepositosController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_sidemenu, only: [:index]
  before_action :set_deposito, only: [:show, :edit, :update, :destroy, :imprimir_factura]
  respond_to :html, :js
  authorize_resource
  def set_sidemenu
    @sidebar_layout = 'layouts/stock_sidemenu'
  end
  def index
    @search = Deposito.search(params[:q])
    @depositos_size = @search.result.size
    if @search.sorts.empty?
      @depositos = @search.result.order('type').page(params[:page])
    else
      @depositos = @search.result.page(params[:page])
    end
  end

  def imprimir_listado
    @search = Deposito.search(params[:q])
    @depositos = @search.result.order('type')

  end

  def setupFechas
      params[:q][:fecha_lt] = params[:q][:fecha_lt] + ' 23:59:59' unless params[:q][:fecha_lt].blank?
  end

  def new

  end

  def create

  end

  def update_list
    index
    render partial: 'update_list', format: 'js'
  end

  def show
    respond_to do |format|
      format.js { render 'show' }
      format.pdf { render :pdf => "deposito",
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

  end

  def set_deposito
    @deposito = Deposito.find(params[:id])
  end

  def deposito_params
    params.require(:deposito).permit(:id,
        deposito_stocks_attributes: [:existencia, :existencia_min, :existencia_max, :id, :mercaderia_id])
  end
end
