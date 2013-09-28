class PedidoCotizacion < ActiveRecord::Base
  has_many :pedido_cotizacion_detalles
end
