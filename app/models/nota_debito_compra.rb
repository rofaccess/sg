class NotaDebitoCompra < ActiveRecord::Base
	has_paper_trail
	acts_as_paranoid

	belongs_to :proveedor, with_deleted: true
	belongs_to :user, with_deleted: true
end
