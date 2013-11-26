class Mercaderia < ActiveRecord::Base
	protokoll :codigo, pattern: '#####'

	belongs_to :iva, with_deleted: true
	has_many   :deposito_stocks
	acts_as_paranoid
end
