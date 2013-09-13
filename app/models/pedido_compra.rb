class PedidoCompra < ActiveRecord::Base
	has_many :pedidos_compra_detalle
end
