class Marca < ActiveRecord::Base
	paginates_per 15
	has_many :componentes
	validates :nombre, presence: true
end
