class User < ActiveRecord::Base
  resourcify
  rolify
  acts_as_paranoid
  paginates_per 15


  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def email_required?
  	false
  end

  has_many :factura_compras
  has_many :orden_compras
  has_many :pedido_cotizacions
  has_many :orden_devolucions
  belongs_to :empleado

  accepts_nested_attributes_for :empleado
end
