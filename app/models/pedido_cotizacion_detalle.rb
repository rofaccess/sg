class PedidoCotizacionDetalle < ActiveRecord::Base
  belongs_to :pedido_cotizacion
  belongs_to :componente
  belongs_to :pedido_compra_detalle
end
