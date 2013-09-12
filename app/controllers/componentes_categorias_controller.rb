class ComponentesCategoriasController < ApplicationController
  before_action :set_componente_categoria, only: [:show, :edit, :update, :destroy]

  # GET /componentes_categorias
  # GET /componentes_categorias.json
  def index
    @componentes_categorias = ComponenteCategoria.all
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

    respond_to do |format|
      if @componente_categoria.save
        format.html { redirect_to @componente_categoria, notice: 'Componente categoria was successfully created.' }
        format.json { render action: 'show', status: :created, location: @componente_categoria }
      else
        format.html { render action: 'new' }
        format.json { render json: @componente_categoria.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /componentes_categorias/1
  # PATCH/PUT /componentes_categorias/1.json
  def update
    respond_to do |format|
      if @componente_categoria.update(componente_categoria_params)
        format.html { redirect_to @componente_categoria, notice: 'Componente categoria was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @componente_categoria.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /componentes_categorias/1
  # DELETE /componentes_categorias/1.json
  def destroy
    @componente_categoria.destroy
    respond_to do |format|
      format.html { redirect_to componentes_categorias_url }
      format.json { head :no_content }
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
