class NotaDebitoCompra < ActiveRecord::Base
	belongs_to :proveedor
	belongs_to :user
end
