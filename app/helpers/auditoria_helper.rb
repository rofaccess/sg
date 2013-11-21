# -*- coding: utf-8 -*-
module AuditoriaHelper
  MENSAJES = {
    pedido_compra: {
      create: 'Se ha generado el pedido de compra N˚ VAR',
      update: 'Se ha actualizado el pedido de compra N˚ VAR',
      destroy: 'Se ha eliminado el pedido de compra N˚ VAR',
    },
    pedido_cotizacion: {
      create: 'Se ha generado el pedido de cotizacion N˚ VAR',
      update: 'Se ha actualizado el pedido de cotizacion N˚ VAR',
      destroy: 'Se ha eliminado el pedido de cotizacion N˚ VAR',
    },
    orden_compra: {
      create: 'Se ha generado la orden de compra N˚ VAR',
      update: 'Se ha actualizado la orden de compra N˚ VAR',
      destroy: 'Se ha eliminado la orden de compra N˚ VAR',
    },
    factura_compra: {
      create: 'Se ha generado la factura de compra N˚ VAR',
      update: 'Se ha actualizado la factura de compra N˚ VAR',
      destroy: 'Se ha eliminado la factura de compra N˚ VAR',
    },
    orden_devolucion: {
      create: 'Se ha generado la orden de devolucion N˚ VAR',
      update: 'Se ha actualizado la orden de devolucion N˚ VAR',
      destroy: 'Se ha eliminado la orden de devolucion N˚ VAR',
    },
    proveedor: {
      create: 'Se ha creado el proveedor VAR',
      update: 'Se ha actualizado el proveedor VAR',
      destroy: 'Se ha eliminado el proveedor VAR',
    },
    user: {
      create: 'Se ha creado el usuario VAR',
      update: 'Se ha actualizado el usuario VAR',
      destroy: 'Se ha eliminado el usuario VAR',
    },
    configuracion: {
      create: '',
      update: 'Se ha actualizado la tabla de configuraciones',
      destroy: '',
    }
  }

  def self.format_event(event, model, id)
    object = model.constantize.with_deleted.find(id)
    variable  = ''
    if model == 'User'
      variable = object.username
    elsif model == 'Proveedor'
      variable = object.nombre
    elsif model == 'Configuracion'
      variable = ''
    else
      variable = object.numero
    end
    MENSAJES[model.underscore.to_sym][event.underscore.to_sym].gsub('VAR', variable)
  end

end