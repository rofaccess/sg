class Estado < ActiveRecord::Base
  belongs_to :pais
  has_many :ciudades
end
