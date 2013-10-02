var facturasCompraUI = (function(){
	return {
		cargarOrdenesDetalles: function(id){
			$.ajax({
				url: 'facturas_compra/get_orden_compra',
				type: 'post',
				dataType: 'html',
				data: {id: id},
				success: function(response){
					$('#main-modal .detalles-orden-compra').html(response);
				}
			});
		},

		init: function(){
			$('body').on('change', '#factura_compra_orden_compra_id', function(e){
				facturasCompraUI.cargarOrdenesDetalles($(this).val());
			});

			$('body').on('click', '.show-orden', function(e){
				$.get($(this).data('url'), {}, function(){}, 'script');
			});
		}
	};
}());

$(function(){
	facturasCompraUI.init();
});