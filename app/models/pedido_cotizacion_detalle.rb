class PedidoCotizacionDetalle < ActiveRecord::Base
  include Formatter

  acts_as_paranoid
  has_paper_trail

  belongs_to :pedido_cotizacion, with_deleted: true
  belongs_to :componente, with_deleted: true
  belongs_to :pedido_compra_detalle, with_deleted: true

  def proveedores
  	PedidoCotizacionDetalle.includes(:pedido_cotizacion).where('pedidos_cotizacion.estado = ?', PedidosEstados::COTIZADO).where('costo_unitario <> ?', 0).where(pedido_compra_detalle: self.pedido_compra_detalle, componente_id: self.componente_id)
  end

  def costo_unitario_f
	Formatter.to_money(self.costo_unitario)
  end
end
