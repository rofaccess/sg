# -*- coding: utf-8 -*-
class NotasDebitoCompraController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_sidemenu, only: [:index]
  before_action :set_nota_debito_compra, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js
  load_and_authorize_resource
  def set_sidemenu
    @sidebar_layout = 'layouts/compras_sidemenu'
  end
  def index
    #formatear las fechas
    if defined? params[:q][:fecha_lt]
      setupFechas
    end

    resultados_notas(true)

  end

  def resultados_notas(paginate)
    @search = NotaDebitoCompra.search(params[:q])
    if @search.sorts.empty?
      @notas_debito_compra = @search.result.order('fecha desc').order('estado desc')
    else
      @notas_debito_compra = @search.result
    end

    if paginate
      @notas_debito_compra_size = @search.result.size
      @notas_debito_compra = @notas_debito_compra.page(params[:page])
    end
  end

  def imprimir_listado
    #formatear las fechas
    if defined? params[:q][:fecha_lt]
      setupFechas
    end
    resultados_notas(false)
    respond_to do |format|
      format.pdf { render :pdf => "notas",
                          :layout => 'pdf.html',
                          :header => { :right => '[page] de [topage]',
                                        :left => "Impreso el  #{Formatter.format_date(DateTime.now)} por #{current_user.username}" }
                  }
    end
  end

  def setupFechas
      params[:q][:fecha_lt] = params[:q][:fecha_lt] + ' 23:59:59' unless params[:q][:fecha_lt].blank?
  end

  def new
    @nota_debito_compra = NotaDebitoCompra.new
  end

  def create
    @nota_debito_compra = NotaDebitoCompra.new(nota_debito_compra_params)
    CompraCuentaCorriente.actualizar_monto_debito(@nota_debito_compra.proveedor_id,@nota_debito_compra.total)
    if @nota_debito_compra.save
      flash.notice = "Se ha creado la nota de débito N˚ #{@nota_debito_compra.numero}."
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
      format.pdf { render :pdf => "nota_debito_compra",
                          :layout => 'pdf.html',
                          :header => { :right => '[page] de [topage]',
                                        :left => "Impreso el  #{Formatter.format_date(DateTime.now)} por #{current_user.username}" }
                  }
    end
  end

  def update
    if @nota_debito_compra.update(nota_debito_compra_params)
      flash.notice = "Se ha actualizado la nota de débito N˚ #{@nota_debito_compra.numero}."
      update_list
    end
  end

  def edit
  end

  def destroy
    if @nota_debito_compra.destroy
      flash.notice = "Se ha eliminado la nota de débito N˚ #{@nota_debito_compra.numero}."
      update_list
    else
      flash.alert = "No se ha podido eliminar la nota de débito N˚ #{@nota_debito_compra.numero}."
      update_list
    end
  end

  def check_numero
    @nota_debito_compra = NotaDebitoCompra.where("numero = ? AND proveedor_id = ?", params[:nota_debito_compra][:numero], params[:proveedor_id])
    if @nota_debito_compra.blank?
      condition = true
    else
      condition = false
    end
    respond_to do |format|
      format.json { render :json => condition}
    end
  end

  def set_nota_debito_compra
    @nota_debito_compra = NotaDebitoCompra.find(params[:id])
    fecha = Formatter.format_date(@nota_debito_compra.fecha)
    @nota_debito_compra.fecha = fecha
  end

  def nota_debito_compra_params
      params.require(:nota_debito_compra).permit(:numero, :fecha, :total, :proveedor_id, :user_id, :estado, :motivo)
  end
end
