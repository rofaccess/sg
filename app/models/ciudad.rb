class Ciudad < ActiveRecord::Base
  has_many :providers
  belongs_to :estado
end
