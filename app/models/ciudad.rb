class Ciudad < ActiveRecord::Base
  has_many :providers
  has_many :proveedores
  belongs_to :estado
end
