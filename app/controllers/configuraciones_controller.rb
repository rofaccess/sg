class ConfiguracionesController < ApplicationController
  before_action :set_configuracion, only: [:show, :edit, :update, :destroy]

  # GET /configuraciones
  # GET /configuraciones.json
  def index
    @configuracion= Configuracion.first
    redirect_to edit_configuracion_path(@configuracion.id)
    #@configuraciones = Configuracion.all
    #@search = Configuracion.search(params[:q])
    #@configuraciones = @search.result
  end

  # GET /configuraciones/1
  # GET /configuraciones/1.json
  def show
  end

  # GET /configuraciones/new
  def new
    @configuracion = Configuracion.new
  end

  # GET /configuraciones/1/edit
  def edit
    #@configuracion= Configuracion.first
  end

  # POST /configuraciones
  # POST /configuraciones.json
  def create
    @configuracion = Configuracion.new(configuracion_params)

    if @configuracion.save
      redirect_to configuraciones_path, notice: t('messages.configuracion_saved')
    else
      redirect_to configuraciones_path, alert: t('messages.configuracion_not_saved')
    end

  end

  # PATCH/PUT /configuraciones/1
  # PATCH/PUT /configuraciones/1.json
  def update
    if @configuracion.update(configuracion_params)
      redirect_to configuraciones_path, notice: t('messages.configuracion_saved')
    else
      redirect_to configuraciones_path, alert: t('messages.configuracion_not_saved')
    end
  end

  # DELETE /configuraciones/1
  # DELETE /configuraciones/1.json
  def destroy
    @configuracion.destroy
    respond_to do |format|
      format.html { redirect_to configuraciones_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_configuracion
      @configuracion = Configuracion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def configuracion_params
      params.require(:configuracion).permit(:nombre, :direccion, :imagen)
    end
end
