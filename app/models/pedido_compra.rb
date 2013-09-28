class PedidoCompra < ActiveRecord::Base
  has_many :pedido_compra_detalles

  # Este metodo retorna todas las categorias que hay en los detalles de un pedido de compra
  def get_componente_categorias
  	categorias = []
    detalles = self.pedido_compra_detalles
      detalles.each do |d|
      	categorias.push(d.componente.componente_categoria_id) unless categorias.include?(d.componente.componente_categoria_id)
      end
    categorias
  end
end
