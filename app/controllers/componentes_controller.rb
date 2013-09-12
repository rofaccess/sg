class ComponentesController < ApplicationController
  before_action :set_componente, only: [:show, :edit, :update, :destroy]

  # GET /componentes
  # GET /componentes.json
  def index
    @componentes = Componente.all
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

    respond_to do |format|
      if @componente.save
        format.html { redirect_to @componente, notice: 'Componente was successfully created.' }
        format.json { render action: 'show', status: :created, location: @componente }
      else
        format.html { render action: 'new' }
        format.json { render json: @componente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /componentes/1
  # PATCH/PUT /componentes/1.json
  def update
    respond_to do |format|
      if @componente.update(componente_params)
        format.html { redirect_to @componente, notice: 'Componente was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @componente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /componentes/1
  # DELETE /componentes/1.json
  def destroy
    @componente.destroy
    respond_to do |format|
      format.html { redirect_to componentes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_componente
      @componente = Componente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def componente_params
      params.require(:componente).permit(:nombre, :numero_serie, :costo, :marca_id, :componente_categoria_id)
    end
end
