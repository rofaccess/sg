class ProveedoresController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_proveedor, only: [:show, :edit, :update, :destroy]
  before_action :set_sidemenu, only: [:index]
  respond_to :html, :js

  def set_sidemenu
    @sidebar_layout = 'layouts/compras_sidemenu'
  end
  def index
  	@proveedores = Proveedor.all
  end

  def edit
  end

  def new
  end

  def show
  end

  def update
  end

  def destroy
  end

  def set_proveedor
    @proveedor = Proveedor.find(params[:id])
  end

  def proveedor_params
      params.require(:proveedor).permit(:persona_id)
  end
end
