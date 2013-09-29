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

			$('body').on('click', '.show-pedido', function(e){
				$.get($(this).data('url'), {}, function(){}, 'script');
			});
		}
	};
}());

$(function(){
	pedidosCotizacionUI.init();
});