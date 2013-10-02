class MarcasController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_sidemenu, only: [:index]
  before_action :set_marca, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def set_sidemenu
    @sidebar_layout = 'layouts/stock_sidemenu'
  end
  # GET /marcas
  # GET /marcas.json
  def index
    @search = Marca.search(params[:q])
    if @search.sorts.empty?
      @marcas = @search.result.order('nombre').page(params[:page]).per(15)
    else
      @marcas = @search.result.page(params[:page]).per(15)
    end
  end

  # GET /marcas/1
  # GET /marcas/1.json
  def show
  end

  # GET /marcas/new
  def new
    @marca = Marca.new
  end

  # GET /marcas/1/edit
  def edit
  end

  # POST /marcas
  # POST /marcas.json
  def create
    @marca = Marca.new(marca_params)

    if @marca.save
        update_list
      else
        redirect_to componentes_path, alert: t('messages.marca_not_saved')
      end
  end

  def update_list
    index
    render partial: 'update_list', format: 'js'
  end

  # PATCH/PUT /marcas/1
  # PATCH/PUT /marcas/1.json
  def update
    if @marca.update(marca_params)
      update_list
    else
      redirect_to componentes_path, alert: t('messages.marca_not_updated')
    end
  end

  # DELETE /marcas/1
  # DELETE /marcas/1.json
  def destroy
    @marca.destroy
    respond_to do |format|
      format.html { redirect_to marcas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marca
      @marca = Marca.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marca_params
      params.require(:marca).permit(:nombre)
    end
end
