class OrdenesComprasController < ApplicationController
  before_action :set_orden_compra, only: [:show, :edit, :update, :destroy]

  # GET /ordenes_compras
  # GET /ordenes_compras.json
  def index
    @ordenes_compras = OrdenCompra.all
  end

  # GET /ordenes_compras/1
  # GET /ordenes_compras/1.json
  def show
  end

  # GET /ordenes_compras/new
  def new
    @orden_compra = OrdenCompra.new
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
    @orden_compra.destroy
    respond_to do |format|
      format.html { redirect_to ordenes_compras_url }
      format.json { head :no_content }
    end
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
