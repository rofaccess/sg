var ordenesCompraUI = (function(){
	return {
		cargarPedidosDetalles: function(id){
			$.ajax({
				url: 'ordenes_compra/get_pedido_compra',
				type: 'post',
				dataType: 'html',
				data: {id: id},
				success: function(response){
					$('#main-modal #seleccion-pedidos').html(response);
				}
			});
		},


		init: function(){
			$('body').on('click', '.orden_compra_pedido_compra_detalles, .recargar-detalles', function(e){
				ordenesCompraUI.cargarPedidosDetalles($(this).data('pedido-id'));
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
				$('#new_orden_compra').find('input:submit').addClass('disabled');
				if($('.cotizacion-detalle').length == 0){
					$('.orden-detalles').addClass('hide');
					$('.recargar-warning').addClass('show');
				}
				e.preventDefault();
			});

			$('body').on('click', '#orden_compra_seleccionar_todo', function(e){
				var submitBtn = $('#new_orden_compra').find('input:submit');
				if($(this).is(':checked')){
					$('.pedido-compra-id-check').attr('checked', true);
					submitBtn.removeClass('disabled');
				}else{
					$('.pedido-compra-id-check').attr('checked', false);
					submitBtn.addClass('disabled');
				}

			});

			$('body').on('change', '.pedido-compra-id-check', function(e){
				var submitBtn = $('#new_orden_compra').find('input:submit');
				if($('.pedido-compra-id-check').is(':checked')){
					submitBtn.removeClass('disabled');
				}else{
					submitBtn.addClass('disabled');
				}
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

			$('body').on('click', '.imprimir-ordenes-compra', function(e){
				var data = $('#orden_compra_search.form-filtros').serialize();
				var url = $(this).attr('href');
				$(this).attr('href', url+'?'+data);
			});
		},

		//Todos los montos en la UI de Pedido de compra se formatean como moneda
		formatearMontos: function(){
			$('.monto').each(function() {
				$(this).text().replace(/^[^\d]*/, '');
    			$(this).number( true, 0,  ',', '.' );
    			var monto = $(this).text();
    			$(this).text($('.simbolo_moneda').text()+ ' ' + monto);
  			});
		}
	};
}());

$(function(){
	ordenesCompraUI.init();
});