class ApplicationController < ActionController::Base
  before_filter :set_configuraciones
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to pages_no_autorizado_path, :alert => exception.message
  end

  def set_configuraciones
     @config = Configuracion.all.first
  end
end
