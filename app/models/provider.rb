class Provider < ActiveRecord::Base
	has_many :products

	validates :name, :ruc, :address, :phone, :email, presence: true
end
