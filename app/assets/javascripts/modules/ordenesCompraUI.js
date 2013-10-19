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
		}
	};
}());

$(function(){
	ordenesCompraUI.init();
});