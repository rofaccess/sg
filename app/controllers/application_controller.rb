class ApplicationController < ActionController::Base
  before_filter :set_configuraciones
  before_filter :set_interfaces_secciones
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to pages_no_autorizado_path, :alert => exception.message
  end

  def set_configuraciones
    @config = Configuracion.all.first
  end

  def set_interfaces_secciones
    if not current_user.blank?
      @rol = Interfaz.get_interfaces_secciones(current_user)
    end  
  end
end
