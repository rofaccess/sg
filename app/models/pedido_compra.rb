class PedidoCompra < ActiveRecord::Base
  protokoll :numero, pattern: '#####'
  paginates_per 15
  has_paper_trail
  acts_as_paranoid

  has_many :pedido_compra_detalles
  has_many :pedido_cotizacions
  has_many :orden_compras
  belongs_to :deposito

  # Este metodo retorna todas las categorias que hay en los detalles de un pedido de compra
  def get_componente_categorias
  	categorias = []
    detalles = self.pedido_compra_detalles
      detalles.each do |d|
      	categorias.push(d.componente.componente_categoria_id) unless categorias.include?(d.componente.componente_categoria_id)
      end
    categorias
  end

  # Retorna los mejores precios para cada componente de un pedido de compra
  def get_mejores_precios
    detalles = self.pedido_compra_detalles
    mejores_precios = {}
    # Por cada detalle/componente recorremos todas sus cotizaciones
    detalles.each do |d|
      cotizaciones = d.cotizados # Cotizaciones cotizadas para este componente
      # Seteamos la primera cotizacion como mejor
      mejor_precio_ids = []

      mejores_precios[d.id] = []
      if cotizaciones.size > 0
        mejor_precio = cotizaciones[0].costo_unitario

        cotizaciones.each do |cotizacion|
          #unless cotizacion.costo_unitario.nil? || cotizacion.costo_unitario == 0
            if cotizacion.costo_unitario < mejor_precio
              mejor_precio = cotizacion.costo_unitario
              mejor_precio_ids = [cotizacion.id]
            elsif cotizacion.costo_unitario == mejor_precio
              mejor_precio_ids.push(cotizacion.id)
            end
          #end
        end
      end
      mejores_precios[d.id] = mejor_precio_ids
    end
    mejores_precios
  end

  def pedidos_cotizados
    self.pedido_cotizacions.where(estado: PedidosEstados::COTIZADO)
  end

  def self.procesados
    PedidoCompra.where(estado: PedidosEstados::PROCESADO)
  end
end
