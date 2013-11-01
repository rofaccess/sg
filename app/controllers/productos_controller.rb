class ProductosController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_sidemenu, only: [:index]
  before_action :set_producto, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js
  def set_sidemenu
    @sidebar_layout = 'layouts/stock_sidemenu'
  end

  def index
  	@search = Producto.search(params[:q])
    @productos = @search.result
    if @search.sorts.empty?
      @componentes = @search.result.order('nombre').page(params[:page])
    else
      @componentes = @search.result.page(params[:page])
    end
  end

  def show
  end
  def new
  	@producto = Producto.new
  end
  def edit
  end

  def create
    @producto = Producto.new(producto_params)

    if @producto.save
      redirect_to productos_path, notice: t('messages.producto_saved')
    else
      redirect_to productos_path, alert: t('messages.producto_not_saved')
    end

  end

  def update
    if @producto.update(producto_params)
      redirect_to productos_path, notice: t('messages.producto_saved')
    else
      redirect_to productos_path, alert: t('messages.producto_not_saved')
    end
  end

  def destroy
    if @producto.destroy
      respond_to do |format|
        format.html { redirect_to productos_url, notice: t('messages.producto_deleted') }
        format.json { head :no_content }
      end
    else
      format.html { redirect_to productos_url, notice: t('messages.producto_not_deleted') }
      format.json { head :no_content }
    end
  end

  def set_producto
    @producto = Producto.find(params[:id])
  end

  def producto_params
      params.require(:producto).permit(:codigo, :nombre, :descripcion, :costo, :iva_id)
  end
end
