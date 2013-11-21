var notasCreditoCompraUI = (function(){
	return {
		cargarFacturaDetalles: function(url, id, replace){
			$.ajax({
				url: url,
				type: 'post',
				dataType: 'html',
				data: {id: id},
				success: function(response){
					$(replace).html(response);
				}
			});
		},

		init: function(){
			$('body').on('change', '#factura_compra_id', function(e){
				notasCreditoCompraUI.cargarFacturaDetalles('notas_credito_compra/get_factura_compra', $(this).val(), '#main-modal .detalles-factura-compra');
			});

			$('body').on('click', '.recargar_factura', function(e){
				notasCreditoCompraUI.cargarFacturaDetalles('notas_credito_compra/get_factura_compra', $('#factura_compra_id').val(), '#main-modal .detalles-factura-compra');
				$('.detalles-factura-compra').removeClass('hide');
				$('.detalles-factura-compra').addClass('show');
				$('.recargar-warning').removeClass('show');
				$('.recargar-warning').addClass('hide');
			});

			$('body').on('click', '.show-nota-c', function(e){
				$.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
			});

			// Evento para remover un detalle de una nota en la pantalla de generar nota de credito
			$('body').on('click', '.remover-detalle-nota-c', function(e){
				$(this).parents('tr.nota-c-detalle').remove();
				if($('.nota-c-detalle').length == 0){
					$('.detalles-factura-compra').removeClass('show');
					$('.detalles-factura-compra').addClass('hide');
					$('.recargar-warning').removeClass('hide');
					$('.recargar-warning').addClass('show');
				}else{
					//Al borrar la fila recalcula los montos
					notasCreditoCompraUI.calcularFormatearMontos();
				}
				e.preventDefault();
			});
		},

		// Calcula y formatea los montos una vez
		calcularFormatearMontos: function(){
		    var total = 0;
		    $('table tbody tr').each(function() {
		      	var precio = parseInt($('td.precio', this).text().replace(/^[^\d.]*/, ''));
		      	var cantidad = parseInt($('td.cantidad input', this).val());
		      	var costo = cantidad * precio;
		      	$('td.costo', this).text(costo);
			    costo = isNaN(costo) ? 0 : costo;
			    total += costo;
		    });
			$('dd.total').text(total);
			$('.total-n').val(total);

			notasCreditoCompraUI.formatearMontos();
		},

		//Todos los montos  se formatean como moneda
		formatearMontos: function(){
			$('.monto-modal').each(function() {
    			$(this).number( true, 0,  ',', '.' );
    			var monto = $(this).text();
    			$(this).text($('.simbolo_moneda').text()+ ' ' + monto);
  			});
		},

		//Al cambiar cantidad, multiplica por precio y actualiza total
		onChangeCantidad: function(){
			$('td.cantidad input').keyup(function(){
		    	var total = 0;
			    $('table tbody tr').each(function() {
			    	var cantidad = parseInt ($('td.cantidad input', this).val());
		      		var faltante = parseInt ($('td.faltante', this).text());
		      		if ((cantidad > faltante) || (cantidad == 0)) {
		      			cantidad = faltante;
		      			$('td.cantidad input', this).val(cantidad);
		      		}
			      	var precio = parseInt($('td.precio', this).text().replace(/^[^\d.]*/, ''));
			      	var cantidad = parseInt($('td.cantidad input', this).val());
			      	var costo = cantidad * precio;
			      	$('td.costo', this).text(costo);
				    costo = isNaN(costo) ? 0 : costo;
				    total += costo;
			    });
			$('dd.total').text(total);
			$('.total-n').val(total);

			notasCreditoCompraUI.formatearMontos();
		  	});
		},

		// Metodo para get factura
		initInGetFacturaCompra: function(){
		  	// En los campos input de cantidad se ignoran los valores que no sean numericos
		  	$('td.cantidad input').numberOnly();

		  	notasCreditoCompraUI.calcularFormatearMontos();

		  	notasCreditoCompraUI.onChangeCantidad();
		  	notasCreditoCompraUI.calcularFormatearMontos();
		  	// Facilita seleccionar una fecha
		   	$(function() {
		    	$('.date').datepicker();
		  	});

		   	// Valida el formulario antes de enviarlo
		  	$('#new_nota_credito_compra').validate();
		}
	};
}());

$(function(){
	notasCreditoCompraUI.init();
});