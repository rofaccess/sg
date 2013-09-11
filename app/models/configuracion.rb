class Configuracion < ActiveRecord::Base
   has_attached_file :imagen, styles: {medium: '100x100>', thumb: '50x50>'}
end
