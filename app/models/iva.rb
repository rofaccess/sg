class Iva < ActiveRecord::Base
	acts_as_paranoid
	has_paper_trail

	has_many :componentes
end
