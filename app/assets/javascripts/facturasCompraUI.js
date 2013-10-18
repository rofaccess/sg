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
			$('body').on('change', '#orden_compra_id', function(e){
				facturasCompraUI.cargarOrdenesDetalles($(this).val());
			});

			$('body').on('change', '#orden_compra_id', function(e){
				$.ajax({
					url: 'facturas_compra',
					type: 'get',
					dataType: 'script',
					data: {orden_compra_id: $(this).val()},
					success: function(response) {
						// body...
					}
				});
			});

			$('body').on('click', '.show-factura', function(e){
				$.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
			});
		}
	};
}());

$(function(){
	facturasCompraUI.init();
});