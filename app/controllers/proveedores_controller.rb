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
  	@proveedor = Proveedor.new
  	@proveedor.persona = Persona.new
  end

  def create
  	@proveedor = Proveedor.new
     params[:proveedor][:componente_categoria_ids].each do |v,k|
       @proveedor.componente_categorias << ComponenteCategoria.find(v) unless v.empty?
     end
  	@proveedor.persona = Persona.new(persona_params)
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
   	if @proveedor.persona.update(persona_params)
       update_list
    else
      redirect_to proveedores_path, alert: t('messages.provider_not_saved')
    end
  end

  def destroy
  	if @proveedor.persona.destroy
      redirect_to proveedores_path, notice: t('messages.provider_deleted')
    else
      redirect_to proveedores_path, alert: t('messages.provider_not_deleted')
    end
  end

  def load_test_data
    @persona = Persona.new(  nombre: Faker::Company.name,
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
    #@persona = Persona.find(@proveedor.persona_id)
  end

  def proveedor_params
      params.require(:proveedor).permit(:persona_id)
  end

  def persona_params
      params.require(:persona).permit(:nombre, :ruc, :direccion, :email, :ciudad_id)
  end
end
