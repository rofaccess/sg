class ComponentesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_sidemenu, only: [:index]
  before_action :set_componente, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def set_sidemenu
    @sidebar_layout = 'layouts/stock_sidemenu'
  end

  # GET /componentes
  # GET /componentes.json
  def index
    @search = Componente.search(params[:q])
    @componente = Componente.new
    if @search.sorts.empty?
      @componentes = @search.result.order('nombre').page(params[:page]).per(10)
    else
      @componentes = @search.result.page(params[:page]).per(10)
    end
  end

  # GET /componentes/1
  # GET /componentes/1.json
  def show
  end

  # GET /componentes/new
  def new
    @componente = Componente.new
  end

  # GET /componentes/1/edit
  def edit
  end

  # POST /componentes
  # POST /componentes.json
  def create
    @componente = Componente.new(componente_params)

      if @componente.save
        update_list
      else
        redirect_to componentes_path, alert: t('messages.proveedor_not_saved')
      end
  end

  def update_list
    index
    render partial: 'update_list', format: 'js'
  end

  # PATCH/PUT /componentes/1
  # PATCH/PUT /componentes/1.json
  def update

    if @componente.update(componente_params)
      update_list
    else
        redirect_to componentes_path, alert: t('messages.proveedor_not_saved')
    end
  end

  # DELETE /componentes/1
  # DELETE /componentes/1.json
  def destroy
    if @componente.destroy
      redirect_to componentes_path, notice: t('messages.proveedor_deleted')
    else
      redirect_to componentes_path, alert: t('messages.proveedor_not_deleted')
    end
  end

  def nueva_marca

    @marca = Marca.new

  end

  def nueva_categoria
    @componente_categoria = ComponenteCategoria.new
  end

  def load_test_data

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_componente
      @componente = Componente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def componente_params
      params.require(:componente).permit(:nombre, :costo, :marca_id, :componente_categoria_id)
    end
end
