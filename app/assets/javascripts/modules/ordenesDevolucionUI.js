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
				ordenesDevolucionUI.cargarDevolucionesDetalles($('#devolucion_orden_compra_id').val());
				$('.detalles-orden-devolucion').removeClass('hide');
				$('.detalles-orden-devolucion').addClass('show');
				$('.recargar-warning').removeClass('show');
				$('.recargar-warning').addClass('hide');
				e.preventDefault();
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



			$('body').on('click', '.imprimir-ordenes-devolucion', function(e){
				$.ajax({
					url: $(this).attr('href'),
					data: $('#orden_devolucion_search.form-filtros').serialize(),
					dataType: 'script'
				});
				e.preventDefault();
			});
		},

		//Al cambiar cantidad, multiplica por precio y actualiza total
		onChangeCantidad: function(){
			$('td.cantidad input').keyup(function(){
		    	$('table tbody tr').each(function() {
		      		var cantidad = parseInt ($('td.cantidad input', this).val());
		      		var faltante = parseInt ($('td.faltante', this).text());
		      		if ((cantidad > faltante)||(cantidad < 1)) {
		      			cantidad = faltante;
		      			$('td.cantidad input', this).val(cantidad);
		      		}
		    	});
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
	ordenesDevolucionUI.init();
});