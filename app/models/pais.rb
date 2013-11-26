class Pais < ActiveRecord::Base
  has_many :estados
  acts_as_paranoid
end
