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
    render partial: 'get_pedido_compra', formats: 'html'

  end

  # GET /ordenes_compras/1/edit
  def edit
  end

  # POST /ordenes_compras
  # POST /ordenes_compras.json
  def create
    @orden_compra = OrdenCompra.new(orden_compra_params)

    respond_to do |format|
      if @orden_compra.save
        format.html { redirect_to @orden_compra, notice: 'Orden compra was successfully created.' }
        format.json { render action: 'show', status: :created, location: @orden_compra }
      else
        format.html { render action: 'new' }
        format.json { render json: @orden_compra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ordenes_compras/1
  # PATCH/PUT /ordenes_compras/1.json
  def update
    respond_to do |format|
      if @orden_compra.update(orden_compra_params)
        format.html { redirect_to @orden_compra, notice: 'Orden compra was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @orden_compra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ordenes_compras/1
  # DELETE /ordenes_compras/1.json


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
