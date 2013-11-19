class Configuracion < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail
  has_attached_file :imagen, styles: {medium: '100x100>', thumb: '30x30>'}
end
