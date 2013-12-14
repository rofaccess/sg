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
    @componentes_categoria = ComponenteCategoria.new
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
        update_list
    else
        redirect_to componentes_categorias_path, alert: t('messages.componente_categoria_not_saved')
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
      update_list
    else
      redirect_to componentes_categoria_path, alert: t('messages.componente_categoria_not_update')
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
