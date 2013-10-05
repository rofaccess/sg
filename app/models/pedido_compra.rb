class PedidoCompra < ActiveRecord::Base
  protokoll :numero, pattern: '#####'
  paginates_per 20

  has_many :pedido_compra_detalles
  has_many :pedido_cotizacions

  # Este metodo retorna todas las categorias que hay en los detalles de un pedido de compra
  def get_componente_categorias
  	categorias = []
    detalles = self.pedido_compra_detalles
      detalles.each do |d|
      	categorias.push(d.componente.componente_categoria_id) unless categorias.include?(d.componente.componente_categoria_id)
      end
    categorias
  end

  def self.procesados
    PedidoCompra.where(estado: PedidosEstados::PROCESADO)
  end
end
