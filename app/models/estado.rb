class Estado < ActiveRecord::Base
  belongs_to :pais, with_deleted: true
  has_many :ciudades
  acts_as_paranoid
end
