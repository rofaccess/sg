class User < ActiveRecord::Base
  rolify
  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def email_required?
  	false
  end

  has_many :factura_compras
  has_many :ordenes_compras
  has_many :pedido_cotizacions
  belongs_to :empleado

  accepts_nested_attributes_for :empleado
end
