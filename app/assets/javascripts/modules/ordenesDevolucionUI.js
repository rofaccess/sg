var ordenesDevolucionUI = (function(){
	return {
		cargarDevolucionesDetalles: function(id){
			$.ajax({
				url: 'ordenes_devolucion/get_orden_compra',
				type: 'post',
				dataType: 'html',
				data: {id: id},
				success: function(response){
					$('#main-modal .detalles-orden-devolucion').html(response);
				}
			});
		},

		init: function(){
			$('body').on('change', '#devolucion_orden_compra_id', function(e){
				ordenesDevolucionUI.cargarDevolucionesDetalles($(this).val());
			});



			$('body').on('click', '.recargar_devolucion', function(e){
				ordenesDevolucionUI.cargarDevolucionesDetalles('ordenes_devolucion/get_orden_compra', $('#devolucion_orden_compra_id').val(), '#main-modal .detalles-orden-devolucion');
				$('.detalles-orden-devolucion').removeClass('hide');
				$('.detalles-orden-devolucion').addClass('show');
				$('.recargar-warning').removeClass('show');
				$('.recargar-warning').addClass('hide');
			});

			$('body').on('click', '.show-pedido', function(e){
				$.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
			});

			$('body').on('click', '.remover-detalle-devolucion', function(e){
				$(this).parents('tr.devolucion-detalle').remove();
				if($('.devolucion-detalle').length == 0){
					$('.detalles-orden-devolucion').removeClass('show');
					$('.detalles-orden-devolucion').addClass('hide');
					$('.recargar-warning').removeClass('hide');
					$('.recargar-warning').addClass('show');
				}
				e.preventDefault();
			});



			$('body').on('click', '.imprimir-ordenes-compra', function(e){
				$.ajax({
					url: $(this).attr('href'),
					data: $('#orden_compra_search.form-filtros').serialize(),
					dataType: 'script'
				});
				e.preventDefault();
			});
		}
	};
}());

$(function(){
	ordenesDevolucionUI.init();
});