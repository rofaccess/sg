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
		},

		// Se carga al hacer render a get_orden_compra
		initInGetOrdenCompra: function(){
		    //Esconde el plazo de pago
		    $('.to-hide').hide();
		    //Desactiva el select de plazos de pago
		    $('#factura_compra_plazo_pago_id').attr("disabled",true);
		    //Remueve opciones vacias
		    $("#factura_compra_condicion_pago_id option:selected").remove();
		    $("#factura_compra_plazo_pago_id option:selected").remove();
		    //Controla los cambios en las opciones de condicion de pago
		    $('#factura_compra_condicion_pago_id').change(function(){
		        if ($(this).find(':selected').val() == '2') {
		        	$('.to-hide').show();
		        	$('#factura_compra_plazo_pago_id').attr("disabled",false);
		    	} else {
		      		$('.to-hide').hide();
		      		$('#factura_compra_plazo_pago_id').attr("disabled",true);
		    	}
		  	});

		  	// En los campos input de cantidad se ignoran los valores que no sean numericos
		  	$('td.cantidad input').keypress(function(event){
		    	if (event.which && (event.which < 48 || event.which > 57)) {
		      		event.preventDefault();
		    	}
		  	});
		  	//Ejecuta el primer calculo al renderizar get_orden_compra
		  	$(function(){
		    	var subtotal = 0;
		    	var total = 0;
		    	var total_iva = 0;
		    	$('table tbody tr').each(function() {
		      		var precio = parseFloat($('td.precio', this).text().replace(/^[^\d.]*/, ''));
		      		var cantidad = parseInt($('td.cantidad input', this).val());
		      		var costo = cantidad * precio;
		      		$('td.costo', this).text(' ' + costo);
			      	var iva_p = ($('td.iva-p input', this).val()) / 100;
			      	var iva = iva_p * costo;
			      	$('td.iva', this).text(' ' + iva.toFixed(0));
			      	costo = isNaN(costo) ? 0 : costo;
			      	iva = isNaN(iva) ? 0 : iva;
			      	subtotal += (costo - iva);
			      	total_iva += iva;
			      	total += costo;
		    	});
			    $('dd.subtotal').text(' ' + subtotal.toFixed(0));
			    $('dd.total-iva').text(' ' + total_iva.toFixed(0));
			    $('dd.total').text(' ' + total);

			    $('.total-f').val(total);
			    $('.total-i').val(total_iva.toFixed(0));
		  	});

		  	//Al cambiar cantidad, multiplica por precio y actualiza total
		  	$('td.cantidad input').keyup(function(){
		    	var subtotal = 0;
		    	var total = 0;
		    	var total_iva = 0;
		    	$('table tbody tr').each(function() {
		      		var precio = parseFloat($('td.precio', this).text().replace(/^[^\d.]*/, ''));
		      		var cantidad = parseInt ($('td.cantidad input', this).val());
		      		var costo = cantidad * precio;
		      		$('td.costo', this).text(' ' + costo);
		      		var iva_p = ($('td.iva-p input', this).val()) / 100;
		      		var iva = iva_p * costo;
		      		$('td.iva', this).text(' ' + iva.toFixed(0));
		      		costo = isNaN(costo) ? 0 : costo;
		      		iva = isNaN(iva) ? 0 : iva;
		      		subtotal += (costo - iva);
		      		total_iva += iva;
		      		total += costo;
		    	});
			    $('dd.subtotal').text(' ' + subtotal.toFixed(0));
			    $('dd.total-iva').text(' ' + total_iva.toFixed(0));
			    $('dd.total').text(' ' + total);

			    $('.total-f').val(total);
			    $('.total-i').val(total_iva.toFixed(0));
		  	});

		   	$(function() {
		    	$('.datepicker').datepicker();
		  	});

		  	$('form').validate();
		}
	};
}());

$(function(){
	facturasCompraUI.init();
});