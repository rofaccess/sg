class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  has_and_belongs_to_many :interfaces, join_table: 'roles_interfaces'
  belongs_to :resource, :polymorphic => true

  scopify
end
