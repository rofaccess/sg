class ApplicationController < ActionController::Base
	before_filter :set_configuraciones
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_configuraciones
     @configuraciones = Configuracion.all

     @configuraciones.each do |p|
	    @nombre = p.nombre
		@direccion = p.direccion
	    @imagen = p.imagen.url(:thumb)
	 end
  end
end
