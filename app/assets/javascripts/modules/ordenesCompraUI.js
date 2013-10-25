var ordenesCompraUI = (function(){
	return {
		cargarPedidosDetalles: function(id){
			$.ajax({
				url: 'ordenes_compras/get_pedido_compra',
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

			$('body').on('click', '.show-pedido', function(e){
				$.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
			});

			$('body').on('click', '.orden-automatica', function(e){
				$.ajax({
					url: 'ordenes_compras',
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