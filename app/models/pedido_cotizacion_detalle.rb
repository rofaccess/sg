class PedidoCotizacionDetalle < ActiveRecord::Base
  belongs_to :pedido_cotizacion
  belongs_to :componente
end
