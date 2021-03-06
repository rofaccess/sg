class UsuariosController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_sidemenu, only: [:index]
  before_action :set_usuario, only: [:edit, :update, :destroy, :edit_password]
  before_action :authorize, only: [:new, :create, :edit, :update, :destroy]
  respond_to :html, :js
  #load_and_authorize_resource

  def authorize
    authorize! :manage, User
  end

  def set_sidemenu
    @sidebar_layout = 'layouts/configuraciones_sidemenu'
  end

  def index
    resultados_usuarios(true)
    authorize! :read, User
  end

  def resultados_usuarios(paginate)
    @search = User.search(params[:q])
    @usuarios = @search.result

    unless params[:user_roles_filtro].nil?
      # if params[:user_roles_filtro] == 'Administrador'
      #   @usuarios = @usuarios.with_role(:admin)
      # elsif params[:user_roles_filtro] == 'Operador'
      #   @usuarios = @usuarios.with_role(:operador)
      # end 
      @usuarios = @usuarios.with_role(Role.find(params[:user_roles_filtro]).name)
      
    end

    if paginate
      @usuarios = @usuarios.page(params[:page])
    end

  end

  def buscar
    index
    render 'index'
  end

  def new
    @usuario = User.new
    @usuario.empleado = Empleado.new
  end

  def create
  	@usuario = User.new(usuario_params)

    if @usuario.password == ''
      @usuario.password = @usuario.username
      @usuario.password_confirmation = @usuario.username
    end

    if @usuario.save
      #if params[:user_roles][:is_admin] == '0' && params[:user_roles][:is_operador] == '0'
      #  @usuario.add_role :operador
      #else
      #  @usuario.add_role :admin if params[:user_roles][:is_admin] == '1'
      #  @usuario.add_role :operador if params[:user_roles][:is_operador] == '1'
      #end
      @usuario.role_ids = params[:user][:role_ids]
      flash.notice = "Se ha creado el usuario #{@usuario.username}."
    else
      flash.notice = "No se ha podido crear el usuario."
  	end
    update_list
  end

  def edit
    render 'new'
  end

  def update
  	if @usuario.update_without_password(usuario_params)
      # @usuario.add_role :admin if !(@usuario.has_role? :admin) && params[:user_roles][:is_admin] == '1'
      # @usuario.add_role :operador if !(@usuario.has_role? :operador) && params[:user_roles][:is_operador] == '1'
      # @usuario.remove_role :admin if (@usuario.has_role? :admin) && params[:user_roles][:is_admin] == '0'
      # @usuario.remove_role :operador if (@usuario.has_role? :operador) && params[:user_roles][:is_operador] == '0'
  	  unless @config.usuario_admin_id == @usuario.id
        @usuario.role_ids = params[:user][:role_ids]
      end
      flash.notice = "Se ha actualizado el usuario #{@usuario.username}."
    else
      flash.notice = "No se ha podido actualizar el usuario."
    end
  	update_list
  end

  def edit_password

  end

  def imprimir_listado
    resultados_usuarios(false)
    respond_to do |format|
      format.pdf { render :pdf => "usuarios",
                          :layout => 'pdf.html',
                          :header => { :right => '[page] de [topage]',
                                        :left => "Impreso el  #{Formatter.format_date(DateTime.now)} por #{current_user.username}" }
                  }
    end
  end

  def destroy
  	unless current_user.id == @usuario.id
      #@usuario.remove_role(:admin)
      #@usuario.remove_role(:operador)
  	  if @usuario.destroy
  	    flash.notice = "Se ha eliminado el usuario #{@usuario.username}"
  	  else
  	    flash.alert = "No se ha eliminado el usuario #{@usuario.username}"
  	  end
    end
    update_list
  end

  def update_list
    index
    render partial: 'update_list', format: 'js'
  end

  def check_username
  	user = User.where(username: params[:user][:username])
  	user_exist = false
  	if user.blank? || user.first.id == params[:user_id].to_i
  		user_exist = true
  	end
  	render json: user_exist
  end

  def check_password
    render json: current_user.valid_password?(params[:user][:current_password])
  end

  private
    def set_usuario
      @usuario = User.find(params[:id])
    end

    def usuario_params
      params.require(:user).permit(:username, :password, :password_confirmation, empleado_attributes: [:id, :nombre, :apellido, :documento_id_num,
      	:direccion, :email])
    end
end