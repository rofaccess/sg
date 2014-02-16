class RolesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_sidemenu, only: [:index]
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js
  authorize_resource

  def set_sidemenu
    @sidebar_layout = 'layouts/configuraciones_sidemenu'
  end

  # GET /componentes
  # GET /componentes.json
  def index
    @role = Role.new
    resultados_roles(true)
  end

  # GET /componentes/1
  # GET /componentes/1.json
  def show
    respond_to do |format|
      format.js  {render 'show'}
    end
  end

  # GET /componentes/new
  def new
    @role = Role.new
  end

  # GET /componentes/1/edit
  def edit
  end

  # POST /componentes
  # POST /componentes.json
  def create
    @role = Role.new(role_params)
    if @role.save
      @role.interfaz_ids = params[:role][:interfaz_ids]
      flash.notice = "Se ha creado el rol #{@role.name}."
      update_list
    else
      flash.notice = "No se ha podido crear el rol #{@role.name}."
    end
  end

  def update_list
    index
    render partial: 'update_list', format: 'js'
  end

  # PATCH/PUT /componentes/1
  # PATCH/PUT /componentes/1.json
  def update
    if @role.update(role_params)
      @role.interfaz_ids = params[:role][:interfaz_ids]
      flash.notice = "Se ha actualizado los datos del rol #{@role.name}."
      update_list
    else
      flash.alert = "No se ha podido actualizar el role #{@role.name}."
    end
  end

  # DELETE /componentes/1
  # DELETE /componentes/1.json
  def destroy
    if @role.destroy
      flash.notice = "Se ha eliminado el rol #{@role.name}."
    else
      flash.alert = "No se ha podido eliminar el rol #{@role.name}."
    end
    update_list
  end 

  def resultados_roles(paginate)
    @search = Role.search(params[:q])
    if @search.sorts.empty?
      @roles = @search.result.order('id desc').page(params[:page])
    else
      @roles = @search.result.page(params[:page])
    end
    if paginate
      @roles_size = @search.result.size
      @roles = @roles.page(params[:page])
    end

  end

  def check_nombre
    role = Role.where(name: params[:role][:name])
    role_exist = false
    if role.blank? || role.first.id == params[:role_id].to_i
      role_exist = true
    end
    render json: role_exist
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:id, :name)
    end	
end
