var ordenesCompraUI = (function(){
	return {
		cargarPedidosDetalles: function(id){
			$.ajax({
				url: 'ordenes_compra/get_pedido_compra',
				type: 'post',
				dataType: 'html',
				data: {id: id},
				success: function(response){
					$('#main-modal .detalles-pedido-compra').html(response);
				}
			});
		},

		init: function(){
			$('body').on('change', '#orden_compra_pedido_compra_id', function(e){
				ordenesCompraUI.cargarPedidosDetalles($(this).val());
			});

			$('body').on('click', '.recargar-detalles', function(e){
				ordenesCompraUI.cargarPedidosDetalles($('#orden_compra_pedido_compra_id').val());
				e.preventDefault();
			});

			$('body').on('change', '.proveedor_for_orden', function(e){
				var values = $(this).val().split('-'),
					row = $(this).parents('tr'),
					cantidad = row.find('.cantidad_cotizada').text().replace(/\./g, '');
				row.find('.hidden-value').attr('name', 'pedido_cotizacion['+values[1]+'][detalles]['+values[0]+']').val(values[0]);
				row.find('.costo_unitario').text(values[2]);
				row.find('.subtotal').text(parseInt(values[2])*parseInt(cantidad));
				$('.monto-text').maskMoney('mask');
			});

			$('body').on('click', '.show-pedido', function(e){
				$.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
			});

			$('body').on('click', '.remover-detalle-orden', function(e){
				$(this).parents('tr.cotizacion-detalle').remove();
				if($('.cotizacion-detalle').length == 0){
					$('.orden-detalles').addClass('hide');
					$('.recargar-warning').addClass('show');
				}
				e.preventDefault();
			});

			$('body').on('click', '.orden-automatica', function(e){
				$.ajax({
					url: 'ordenes_compra',
					type: 'post',
					dataType: 'script',
					data: {pedido_compra_id: $('#orden_compra_pedido_compra_id').val()},
					success: function(response){
						$('#main-modal .detalles-pedido-compra').html(response);
					}
				});
				e.preventDefault();
			});
		}
	};
}());

$(function(){
	ordenesCompraUI.init();
});