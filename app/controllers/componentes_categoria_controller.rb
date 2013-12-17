class ComponentesCategoriaController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_sidemenu, only: [:index]
  before_action :set_componente_categoria, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def set_sidemenu
    @sidebar_layout = 'layouts/stock_sidemenu'
  end
  # GET /componentes_categorias
  # GET /componentes_categorias.json
  def index
    @search = ComponenteCategoria.search(params[:q])
    @componentes_categoria_size = @search.result.size
    @componente_categoria = ComponenteCategoria.new
    if @search.sorts.empty?
      @componentes_categoria = @search.result.order('nombre').page(params[:page])
    else
      @componentes_categoria = @search.result.page(params[:page])
    end
  end

  # GET /componentes_categorias/1
  # GET /componentes_categorias/1.json
  def show
  end

  # GET /componentes_categorias/new
  def new
    @componente_categoria = ComponenteCategoria.new
  end

  # GET /componentes_categorias/1/edit
  def edit
  end

  # POST /componentes_categorias
  # POST /componentes_categorias.json
  def create
    @componente_categoria = ComponenteCategoria.new(componente_categoria_params)
    if @componente_categoria.save
      flash.notice= "Se ha creado la categoria #{@componente_categoria.nombre}."
      update_list
    else
      flash.alert = "No se ha podido crear la categoria #{@componente_categoria.nombre}."
    end
  end

  def update_list
    index
    render partial: 'update_list', format: 'js'
  end

  # PATCH/PUT /componentes_categorias/1
  # PATCH/PUT /componentes_categorias/1.json
  def update
    if @componente_categoria.update(componente_categoria_params)
      flash.notice = "Se ha actualizado la categoria #{@componente_categoria.nombre}."
      update_list
    else
      flash.alert = "No se ha podido actualizar la categoria #{@componente_categoria.nombre}."
    end
  end

  # DELETE /componentes_categorias/1
  # DELETE /componentes_categorias/1.json
  def destroy
    componente = Componente.find_by_componente_categoria_id(@componente_categoria.id)
    if(componente.blank?)
      if @componente_categoria.destroy
        flash.notice = "Se ha eliminado la categoria #{@componente_categoria.nombre}."
        index
      else
        flash.alert = "No se ha podido eliminar la categoria #{@componente_categoria.nombre}."
      end
    else
      flash.notice = "No se ha podido eliminar #{@componente_categoria.nombre}, porque el componente #{componente.nombre} pertenece a esta categoria."
      index
    end
  end

  def check_nombre
    componente_categoria = ComponenteCategoria.where(nombre: params[:componente_categoria][:nombre])
    componente_categoria_exist = false
    if componente_categoria.blank? || componente_categoria.first.id == params[:componente_categoria_id].to_i
      componente_categoria_exist = true
    end
    render json: componente_categoria_exist
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_componente_categoria
      @componente_categoria = ComponenteCategoria.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def componente_categoria_params
      params.require(:componente_categoria).permit(:nombre)
    end
end
