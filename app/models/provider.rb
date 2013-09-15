class Provider < ActiveRecord::Base
	has_many :products
	has_and_belongs_to_many :componente_categorias
	belongs_to :ciudad

	validates :name, :ruc, :address, :phone, :email, :ciudad_id, presence: true
end
