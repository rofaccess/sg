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
    @marcas_size = @search.result.size
    if @search.sorts.empty?
      @marcas = @search.result.order('nombre').page(params[:page])
    else
      @marcas = @search.result.page(params[:page])
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
    mar = Marca.find_by_nombre(@marca.nombre)
    if mar.blank?
      if @marca.save
        flash.notice= "Se ha creado la marca #{@marca.nombre}."
        update_list
      else
        flash.alert = "No se ha podido crear la marca #{@marca.nombre}."
      end
    else
      flash.notice = "No se ha podido crear la marca #{@marca.nombre}, porque ya existe"
      update_list
    end
  end

  def update_list
    index
    render partial: 'update_list', format: 'js'
  end

  # PATCH/PUT /marcas/1
  # PATCH/PUT /marcas/1.json
  def update
    mar = Marca.find_by_nombre((Marca.new(marca_params)).nombre)
    if mar.blank?
      if @marca.update(marca_params)
        flash.notice = "Se ha actualizado la marca #{@marca.nombre}."
        update_list
      else
        flash.alert = "No se ha podido actualizar la marca #{@marca.nombre}."
      end
    else
      if mar.nombre == @marca.nombre
        flash.notice = "Se ha actualizado la marca #{@marca.nombre}."
        update_list
      else
        flash.notice = "No se ha podido actualizar la marca #{mar.nombre}, porque el nombre especificado ya existe"
        update_list
      end
    end
  end

  # DELETE /marcas/1
  # DELETE /marcas/1.json
  def destroy
    componente = Componente.find_by_marca_id(@marca.id)
    if(componente.blank?)
      if @marca.destroy
        flash.notice = "Se ha eliminado la marca #{@marca.nombre}."
        index
      else
        flash.alert = "No se ha podido eliminar la marca #{@marca.nombre}."
      end
    else
      flash.notice = "No se ha podido eliminar #{@marca.nombre}, porque el componente #{componente.nombre} pertenece a esta marca."
      index
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
