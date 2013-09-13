class PedidoCompraDetalle < ActiveRecord::Base
	belongs_to :pedido_compra
	belongs_to :componente
end
