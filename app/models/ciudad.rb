class Ciudad < ActiveRecord::Base
  has_many :proveedores
  belongs_to :estado, with_deleted: true
  acts_as_paranoid
end
