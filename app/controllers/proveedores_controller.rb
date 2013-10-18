class ProveedoresController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_proveedor, only: [:show, :edit, :update, :destroy]
  before_action :set_sidemenu, only: [:index]
  respond_to :html, :js

  def set_sidemenu
    @sidebar_layout = 'layouts/compras_sidemenu'
  end
  def index
    @search = Proveedor.search(params[:q])
    if @search.sorts.empty?
      @proveedores = @search.result.order('nombre').page(params[:page]).per(10)
    else
      @proveedores = @search.result.page(params[:page]).per(10)
    end
  end

  def edit
  end

  def new
  	@proveedor = Proveedor.new
  end

  def create
  	@proveedor = Proveedor.new(proveedor_params)
    params[:proveedor][:componente_categoria_ids].each do |v,k|
       @proveedor.componente_categorias << ComponenteCategoria.find(v) unless v.empty?
    end
  	if @proveedor.save
  		update_list
  	end
  end

  def update_list
    index
    render partial: 'update_list', format: 'js'
  end

  def show
  end

  def update
    old_cat = @proveedor.componente_categoria_ids
    new_cat = params[:proveedor][:componente_categoria_ids]

    old_cat.each do |o|
     @proveedor.componente_categorias.destroy(ComponenteCategoria.find(o)) unless new_cat.include?(o)
    end

    new_cat.each do |n|
     @proveedor.componente_categorias << ComponenteCategoria.find(n) unless n.empty? || old_cat.include?(n)
    end
   	if @proveedor.update(proveedor_params)
       update_list
    else
      redirect_to proveedores_path, alert: t('messages.proveedor_not_saved')
    end
  end

  def destroy
  	if @proveedor.destroy
      redirect_to proveedores_path, notice: t('messages.proveedor_deleted')
    else
      redirect_to proveedores_path, alert: t('messages.proveedor_not_deleted')
    end
  end

  def load_test_data
    @proveedor = Proveedor.new(  nombre: Faker::Company.name,
            ruc: Faker::Number.number(9),
            direccion: Faker::Address.street_address,
            email: Faker::Internet.email)
  end

  def nueva_ciudad
    @ciudad = Ciudad.new
    @paises = Pais.all
    @estados = Estado.all
  end

   def nueva_categoria
     @componente_categoria = ComponenteCategoria.new
   end

  def set_proveedor
    @proveedor = Proveedor.find(params[:id])
  end

  def proveedor_params
      params.require(:proveedor).permit(:nombre, :ruc, :direccion, :email, :ciudad_id)
  end
end
