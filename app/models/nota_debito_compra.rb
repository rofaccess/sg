class NotaDebitoCompra < ActiveRecord::Base
	has_paper_trail
	acts_as_paranoid

	belongs_to :proveedor
	belongs_to :user
end
