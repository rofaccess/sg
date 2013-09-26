class Ciudad < ActiveRecord::Base
  has_many :proveedores
  belongs_to :estado
end
