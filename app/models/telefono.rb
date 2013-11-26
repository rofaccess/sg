class Telefono < ActiveRecord::Base
	belongs_to :persona, with_deleted: true
end
