class Interfaz < ActiveRecord::Base
  has_and_belongs_to_many :roles, join_table: 'roles_interfaces'

  # Obtiene las interfaces y secciones accesibles del ususario logueado
  def self.get_interfaces_secciones(user_id) 
    roles = User.find(user_id).role_ids
    rol = {:interfaces=>Array.new, :secciones=>Array.new}
    roles.each do |role_id|
      RolInterfaz.where(role_id: role_id).each do |rol_interfaz|

        if not rol[:interfaces].include?(rol_interfaz.interfaz.nombre)
          rol[:interfaces].push(rol_interfaz.interfaz.nombre)
        end

        if not rol[:secciones].include?(rol_interfaz.interfaz.seccion)
          rol[:secciones].push(rol_interfaz.interfaz.seccion)
        end
      end
    end
    rol
  end
  
end
