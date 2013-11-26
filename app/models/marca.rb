class Marca < ActiveRecord::Base
	paginates_per 15
	has_many :componentes
	validates :nombre, presence: true
	acts_as_paranoid
end
