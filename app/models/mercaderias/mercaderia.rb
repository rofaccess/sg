class Mercaderia < ActiveRecord::Base
	protokoll :codigo, pattern: '#####'

	belongs_to :iva, with_deleted: true
end
