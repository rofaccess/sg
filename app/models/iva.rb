class Iva < ActiveRecord::Base
	acts_as_paranoid

	has_many :componentes
end
