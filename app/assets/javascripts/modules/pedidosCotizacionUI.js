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

			$('body').on('click', '.show-pedido-cotizacion', function(e){
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

			$('body').on('change', '.checkbox-pedido-compra', function(e){
				var submitBtn = $(this).parents('#new_pedido_cotizacion').find('input[type="submit"]');
				if($('.checkbox-pedido-compra').is(':checked')){
					submitBtn.removeClass('disabled');
				}else{
					submitBtn.addClass('disabled');
				}
			});

		}
	};
}());

$(function(){
	pedidosCotizacionUI.init();
});