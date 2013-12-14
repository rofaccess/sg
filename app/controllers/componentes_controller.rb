# -*- coding: utf-8 -*-
class ComponentesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_sidemenu, only: [:index]
  before_action :set_componente, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def set_sidemenu
    @sidebar_layout = 'layouts/stock_sidemenu'
  end

  # GET /componentes
  # GET /componentes.json
  def index
    @search = Componente.search(params[:q])
    @componentes_size = @search.result.size
    @componente = Componente.new
    if @search.sorts.empty?
      @componentes = @search.result.order('id desc').page(params[:page])
    else
      @componentes = @search.result.page(params[:page])
    end
  end

  # GET /componentes/1
  # GET /componentes/1.json
  def show
  end

  # GET /componentes/new
  def new
    @componente = Componente.new
  end

  # GET /componentes/1/edit
  def edit
  end

  # POST /componentes
  # POST /componentes.json
  def create
    @componente = Componente.new(componente_params)
      if @componente.save
        DepositoStock.cargar_deposito_stock(@componente.id)
        flash.notice = "Se ha creado el componente #{@componente.nombre}."
        update_list
      else
        flash.notice = "No se ha podido crear el componente #{@componente.nombre}."
      end
  end

  def update_list
    index
    render partial: 'update_list', format: 'js'
  end

  # PATCH/PUT /componentes/1
  # PATCH/PUT /componentes/1.json
  def update

    if @componente.update(componente_params)
      flash.notice = "Se ha actualizado los datos del componente #{@componente.nombre}."
      update_list
    else
        flash.alert = "No se ha podido actualizar el componente #{@componente.nombre}."
    end
  end

  # DELETE /componentes/1
  # DELETE /componentes/1.json
  def destroy
    # Verifica  los  pedidos_compra pendientes
    pedido = PedidoCompra.get_pedido_pendiente_procesado_con_componente(@componente.id)
    if pedido == nil
      # Verifica  las ordenes pendientes
      orden = OrdenCompra.get_orden_pendiente_semifacturado_con_componente(@componente.id)
      if orden == nil

        # Verifica los deposito_stock
        deposito_stock = DepositoStock.find_by_mercaderia_id(@componente.id)
        if(deposito_stock.existencia == 0)
          DepositoStock.destroy_depositos_stock(@componente.id)
          destroy_aux
        else
          flash.notice = "No se ha podido eliminar el componente #{@componente.nombre}, porque en el deposito #{deposito_stock.deposito.nombre} hay #{deposito_stock.existencia} en stock."
          index
        end

      else
        flash.notice = "No se ha podido eliminar el componente #{@componente.nombre}, porque figura en la orden de compra #{PedidosEstados::ESTADOS[orden.estado]} Nº #{orden.numero}"
        index
      end
    else
      flash.notice = "No se ha podido eliminar el componente #{@componente.nombre}, porque figura en el pedido de compra #{PedidosEstados::ESTADOS[pedido.estado]} Nº #{pedido.numero}"
      index
    end
  end

  def destroy_aux
    if @componente.destroy
      flash.notice = "Se ha eliminado el componente #{@componente.nombre}."
      index
    else
      flash.alert = "No se ha podido eliminar el componente #{@componente.nombre}."
    end
  end

  def nueva_marca

    @marca = Marca.new

  end

  def nueva_categoria
    @componente_categoria = ComponenteCategoria.new
  end

  def load_test_data

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_componente
      @componente = Componente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def componente_params
      params.require(:componente).permit(:nombre, :costo, :marca_id, :componente_categoria_id, :iva_id)
    end
end
