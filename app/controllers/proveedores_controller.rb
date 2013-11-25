class ProveedoresController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_proveedor, only: [:show, :edit, :update, :destroy]
  before_action :set_sidemenu, only: [:index]
  respond_to :html, :js

  def set_sidemenu
    @sidebar_layout = 'layouts/compras_sidemenu'
  end

  def index
    resultados_proveedores(true)
  end

  def resultados_proveedores(paginate)
    @search = Proveedor.search(params[:q])
    if @search.sorts.empty?
      @proveedores = @search.result.order('nombre')
    else
      @proveedores = @search.result
    end
    @proveedores = @proveedores.page(params[:page]) if paginate
  end

  def edit
  end

  def new
  	@proveedor = Proveedor.new
    @proveedor.telefonos.build
  end

  def create
  	@proveedor = Proveedor.new(proveedor_params)
    params[:proveedor][:componente_categoria_ids].each do |v,k|
      @proveedor.componente_categorias << ComponenteCategoria.find(v) unless v.empty?
    end
    if @proveedor.save
      flash.notice = "Se ha creado el proveedor #{@proveedor.nombre}."
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
      flash.notice = "Se ha actualizado el proveedor #{@proveedor.nombre}."
    else
      flash.notice = "No se ha actualizado el proveedor #{@proveedor.nombre}."
    end
    update_list
  end

  def destroy
    if @proveedor.destroy
      flash.notice = "Se ha eliminado el proveedor #{@proveedor.nombre}."
    else
      flash.alert = "No se ha podido eliminar el proveedor #{@proveedor.nombre}."
    end
    update_list
  end

  def load_test_data
    @proveedor = Proveedor.new(  nombre: Faker::Company.name,
            ruc: Faker::Number.number(9),
            direccion: Faker::Address.street_address,
            email: Faker::Internet.email)
  end

  def imprimir_todos
    resultados_proveedores(false)
    respond_to do |format|
      format.pdf { render :pdf => "proveedores",
                          :layout => 'pdf.html',
                          :header => { :right => '[page] de [topage]',
                                        :left => "Impreso el  #{Formatter.format_date(DateTime.now)} por #{current_user.username}" }
                  }
    end
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
      params.require(:proveedor).permit(:nombre, :ruc, :direccion, :email, :ciudad_id,
        telefonos_attributes: [:id, :numero, :_destroy])
  end
end
