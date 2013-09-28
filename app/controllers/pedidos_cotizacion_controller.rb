class PedidosCotizacionController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_pedido_cotizacion, only: [:show, :edit, :update, :destroy]
  before_action :set_sidemenu, only: [:index]
  respond_to :html, :js

  def set_sidemenu
    @sidebar_layout = 'layouts/compras_sidemenu'
  end

  # GET /pedido_cotizacions
  # GET /pedido_cotizacions.json
  def index
    @pedidos_cotizacion = PedidoCotizacion.all
  end

  # GET /pedido_cotizacions/1
  # GET /pedido_cotizacions/1.json
  def show
  end

  # GET /pedido_cotizacions/new
  def new
    @pedidos_compra = PedidoCompra.where(estado: 'Pendiente')
    @pedido_cotizacion = PedidoCotizacion.new
  end

  # GET /pedido_cotizacions/1/edit
  def edit
  end

  # POST /pedido_cotizacions
  # POST /pedido_cotizacions.json
  def create
    @pedido_cotizacion = PedidoCotizacion.new(pedido_cotizacion_params)

    respond_to do |format|
      if @pedido_cotizacion.save
        format.html { redirect_to @pedido_cotizacion, notice: 'Pedido cotizacion was successfully created.' }
        format.json { render action: 'show', status: :created, location: @pedido_cotizacion }
      else
        format.html { render action: 'new' }
        format.json { render json: @pedido_cotizacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pedido_cotizacions/1
  # PATCH/PUT /pedido_cotizacions/1.json
  def update
    respond_to do |format|
      if @pedido_cotizacion.update(pedido_cotizacion_params)
        format.html { redirect_to @pedido_cotizacion, notice: 'Pedido cotizacion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pedido_cotizacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pedido_cotizacions/1
  # DELETE /pedido_cotizacions/1.json
  def destroy
    @pedido_cotizacion.destroy
    respond_to do |format|
      format.html { redirect_to pedido_cotizacions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pedido_cotizacion
      @pedido_cotizacion = PedidoCotizacion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pedido_cotizacion_params
      params.require(:pedido_cotizacion).permit(:numero, :proveedor_id, :estado, :fecha_creacion, :fecha_cotizado, :user_id, :pedido_compra_id)
    end
end
