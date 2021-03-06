# -*- coding: utf-8 -*-
module AuditoriaHelper
  MENSAJES = {
    pedido_compra: {
      create: 'Se ha generado el pedido de compra N˚ VAR',
      update: 'Se ha cambiado el estado del pedido de compra N˚ 1 a 2',
      destroy: 'Se ha eliminado el pedido de compra N˚ VAR',
    },
    pedido_cotizacion: {
      create: 'Se ha generado el pedido de cotización N˚ VAR',
      update: 'Se ha actualizado el pedido de cotización N˚ VAR',
      destroy: 'Se ha eliminado el pedido de cotización N˚ VAR',
    },
    orden_compra: {
      create: 'Se ha generado la orden de compra N˚ VAR',
      update: 'Se ha cambiado el estado de la orden de compra N˚ 1 a 2',
      destroy: 'Se ha eliminado la orden de compra N˚ VAR',
    },
    factura_compra: {
      create: 'Se ha generado la factura de compra N˚ VAR',
      update: 'Se ha actualizado la factura de compra N˚ VAR',
      destroy: 'Se ha eliminado la factura de compra N˚ VAR',
    },
    orden_devolucion: {
      create: 'Se ha generado la orden de devolución N˚ VAR',
      update: 'Se ha actualizado la orden de devolución N˚ VAR',
      destroy: 'Se ha eliminado la orden de devolución N˚ VAR',
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
      login: 'El usuario ha ingresado al sistema',
      logout: 'El usuario ha salido del sistema'
    },
    empleado: {
      create: 'Se ha creado el empleado VAR',
      update: 'Se ha actualizado el empleado VAR',
      destroy: 'Se ha eliminado el empleado VAR'
    },
    nota_credito_compra: {
      create: 'Se ha creado la nota de crédito N˚ VAR',
      update: 'Se ha actualizado la nota de crédito N˚ VAR',
      destroy: 'Se ha eliminado la nota de crédito N˚ VAR'
    },
    nota_debito_compra: {
      create: 'Se ha creado la nota de debito N˚ VAR',
      update: 'Se ha actualizado la nota de debito N˚ VAR',
      destroy: 'Se ha eliminado la nota de débito N˚ VAR'
    },
    configuracion: {
      create: '',
      update: 'Se han actualizado los Datos de la Empresa',
      destroy: '',
    },
    deposito_materia_prima: {
      create: 'Se ha creado el deposito VAR',
      update: 'Se ha actualizado el deposito VAR',
      destroy: 'Se ha eliminado el deposito VAR',
    },
    deposito_producto_terminado: {
      create: 'Se ha creado el deposito VAR',
      update: 'Se ha actualizado el deposito VAR',
      destroy: 'Se ha eliminado el deposito VAR',
    },
    componente: {
      create: 'Se ha creado el componente VAR',
      update: 'Se ha actualizado el componente VAR',
      destroy: 'Se ha eliminado el componente VAR',
    },
    marca: {
      create: 'Se ha creado la marca VAR',
      update: 'Se ha actualizado la marca VAR',
      destroy: 'Se ha eliminado la marca VAR',
    },
    componente_categoria: {
      create: 'Se ha creado la categoria VAR',
      update: 'Se ha actualizado la categoria VAR',
      destroy: 'Se ha eliminado la categoria VAR',
    },
    asiento_contable: {
      create: 'Se ha generado un asiento automatico para VAR'
    },
    iva: {
      create: 'Se ha creado el tipo de IVA VAR',
      update: 'Se ha modificado el de IVA VAR',
      destroy: 'Se ha eliminado el IVA VAR'
    },
    plazo_pago: {
      create: 'Se ha creado el plazo de pago VAR',
      update: 'Se ha modificado el plazo de pago VAR',
      destroy: 'Se ha eliminado el plazo de pago VAR'
    },
    auth: {

    }
  }

  SECCIONES = {
    pedido_compra: 'Pedidos de Compra',
    pedido_cotizacion: 'Pedidos de Cotización',
    orden_compra: 'Ordenes de Compra',
    factura_compra: 'Facturas de compras',
    orden_devolucion: 'Ordenes de Devolución',
    nota_credito_compra: 'Notas de crédito',
    nota_debito_compra: 'Notas de débito',
    configuracion: 'Configuracion',
    asiento_contable: 'Asiento Contable',
    user: 'Usuarios',
    iva: 'IVA',
    plazo_pago: 'Plazo de Pago',
    persona: {
      empleado: 'Empleados',
      proveedor: 'Proveedores'
    },
    mercaderia: {
      componente: 'Componentes'
    },
    deposito: {
      deposito_materia_prima: 'Despositos de Materia Prima',
      deposito_producto_terminado: 'Despositos de Producto Terminado'
    },
    marca: 'Marcas',
    componente_categoria: 'Categorias de Componente',
    configuracion: 'Configuraciones',
    auth: 'Autenticación'
  }

  def self.format_seccion(model, subclase)
    subclase.nil? ? SECCIONES[model.underscore.to_sym] : SECCIONES[model.underscore.to_sym][subclase.underscore.to_sym]
  end

  def self.format_event(event, model, id, version)
    mensaje = ''
    model = 'User' if model == 'Auth'
    version = PaperTrail::Version.find(version)

    objeto = model.constantize.with_deleted.find(id)
    variable  = ''
    if model == 'User'
      variable = objeto.username
    elsif model == 'Marca'
      variable = objeto.nombre
    elsif model == 'ComponenteCategoria'
      variable = objeto.nombre
    elsif model == 'Persona'
      variable = objeto.nombre
      model = objeto.type
    elsif model == 'Mercaderia'
      variable = objeto.nombre
      model = objeto.type
    elsif model == 'Deposito'
      variable = objeto.nombre
      model = objeto.type
    elsif model == 'Configuracion' || model == 'Auth'
      variable = ''
    elsif model == 'AsientoContable'
      variable = objeto.concepto
    elsif model == 'Iva'
      variable = objeto.valor
    elsif model == 'PlazoPago'
      variable = objeto.nombre
    else
      variable = objeto.numero
    end


    if event == 'update' && (model == 'PedidoCompra' || model == 'OrdenCompra')
      next_version = objeto.version_at(version.created_at)
      mensaje = MENSAJES[model.underscore.to_sym][event.underscore.to_sym].gsub(/[12]/, '1' => variable, '2' => PedidosEstados::ESTADOS[next_version.estado])

    else
      mensaje = MENSAJES[model.underscore.to_sym][event.underscore.to_sym].gsub('VAR', variable)
    end
    mensaje
  end

end