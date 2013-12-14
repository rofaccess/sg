# -*- coding: utf-8 -*-
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

    resultados_notas(true)
  end

  def resultados_notas(paginate)
    @search = NotaCreditoCompra.search(params[:q])
    if @search.sorts.empty?
      @notas_credito_compra = @search.result.order('fecha desc')
    else
      @notas_credito_compra = @search.result
    end

    if paginate
      @notas_credito_compra_size = @search.result.size
      @notas_credito_compra = @notas_credito_compra.page(params[:page])
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

    # Al crear una nota de credito en base a una factura, se carga cantidad_credito en el detalle de la factura
    # que representa la cantidad que se resta de la factura
    if actualizarCantidadCreditoFactura(@nota_credito_compra)
      flash.notice = "No se ha podido crear la nota de credito, porque al menos un componente ya no existe en la base de datos"
      update_list
    elsif @nota_credito_compra.save
      CompraCuentaCorriente.actualizar_monto_credito(@nota_credito_compra.proveedor_id,@nota_credito_compra.total)
      flash.notice = "Se ha creado la nota de credito N˚ #{@nota_credito_compra.numero}."
      update_list
    end
  end

  def actualizarCantidadCreditoFactura(nota_credito)
    nota_credito.nota_credito_compra_detalles.each do |n|
      if Componente.find_by_id(n.componente_id).blank?
        #flash.notice = "No se ha podido crear la nota de crédito N˚ #{nota_credito.numero}, porque el componente #{n.componente.nombre} ya no existe"
        #update_list
        return true
      end
      factura_detalle = FacturaCompraDetalle.find(n.factura_compra_detalle_id)
      cantidad_credito = factura_detalle.cantidad_credito
      factura_detalle.update(cantidad_credito: (cantidad_credito + n.cantidad))

      # Resta del stock las cantidades de la nota de credito
      DepositoStock.restar_deposito_stock(nota_credito, n)
    end
    return false
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
      flash.notice = "Se ha eliminado la nota de credito N˚ #{@nota_credito_compra.numero}."
      update_list
    else
      flash.alert = "No se ha podido eliminar la nota de crédito N˚ #{@nota_credito_compra.numero}."
      update_list
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
