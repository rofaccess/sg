var pedidosCotizacionUI = (function(){
	return {
		cargarPedidosDetalles: function(id){
			$.ajax({
				url: 'pedidos_cotizacion/get_pedido_compra',
				type: 'post',
				dataType: 'html',
				data: {id: id},
				success: function(response){
					$('#main-modal .detalles-pedido-compra').html(response);
				}
			});
		},

		init: function(){
			$('body').on('change', '#pedido_cotizacion_pedido_compra_id', function(e){
				pedidosCotizacionUI.cargarPedidosDetalles($(this).val());
			});

			$('body').on('change', '#pedido_compra_id', function(e){
				$.ajax({
					url: 'pedidos_cotizacion',
					type: 'get',
					dataType: 'script',
					data: {pedido_compra_id: $(this).val()},
					success: function(response) {
						// body...
					}
				});
			});

			$('body').on('click', '.show-pedido', function(e){
				$.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
			});

			$('body').on('click', '.imprimir-pedidos-cotizacion', function(e){
				$.ajax({
					url: $(this).attr('href'),
					data: $('#pedido_cotizacion_search.form-filtros').serialize(),
					dataType: 'script'
				});
				e.preventDefault();
			});

		}
	};
}());

$(function(){
	pedidosCotizacionUI.init();
});