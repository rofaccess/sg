class Provider < ActiveRecord::Base
	has_many :products
	belongs_to :ciudad

	validates :name, :ruc, :address, :phone, :email, :ciudad_id, presence: true
end
