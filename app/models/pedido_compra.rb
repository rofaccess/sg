class PedidoCompra < ActiveRecord::Base
  protokoll :numero, pattern: '#####'
  paginates_per 15

  has_many :pedido_compra_detalles
  has_many :pedido_cotizacions
  has_many :orden_compras

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
    mejores_precios = []
    # Por cada detalle/componente recorremos todas sus cotizaciones
    detalles.each do |d|
      cotizaciones = d.cotizados # Cotizaciones cotizadas para este componente
      # Seteamos la primera cotizacion como mejor
      mejor_precio = cotizaciones[0].costo_unitario
      mejor_precio_id = cotizaciones[0].id

      cotizaciones.each do |cotizacion|
        if !cotizacion.costo_unitario.nil? && cotizacion.costo_unitario < mejor_precio
          mejor_precio = cotizacion.costo_unitario
          mejor_precio_id = cotizacion.id
        end
      end
      mejores_precios.push(mejor_precio_id)
    end
    mejores_precios
  end

  def self.procesados
    PedidoCompra.where(estado: PedidosEstados::PROCESADO)
  end
end
