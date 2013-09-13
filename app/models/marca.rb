class Marca < ActiveRecord::Base
	has_many :componentes
	validates :nombre, presence: true
end
