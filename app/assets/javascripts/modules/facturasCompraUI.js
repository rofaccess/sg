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

			$('body').on('click', '.show-factura', function(e){
				$.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
			});

			// Evento para remover un detalle de una factura en la pantalla de generar factura de compra
			$('body').on('click', '.remover-detalle-factura', function(e){
				$(this).parents('tr.factura-detalle').remove();
				e.preventDefault();
			});
		},

		//Todos los montos en la UI de Factura de compra se formatean como moneda
		formatearMontos: function(){
			$('.monto').each(function() {
    			$(this).number( true, 0,  ',', '.' )
    			var monto = $(this).text();
    			$(this).text($('.simbolo_moneda').text()+ ' ' + monto);
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
		    	var iva5 = 0;
		    	var iva10 = 0;
		    	$('table tbody tr').each(function() {
		      		var precio = parseInt($('td.precio', this).text().replace(/^[^\d.]*/, ''));
		      		var cantidad = parseInt($('td.cantidad input', this).val());
		      		var costo = cantidad * precio;
		      		$('td.costo', this).text(costo);
			      	var iva_p = ($('td.iva-p input', this).val()) / 100;
			      	var iva = iva_p * costo;
			      	$('td.iva', this).text(iva.toFixed(0));
			      	costo = isNaN(costo) ? 0 : costo;
			      	iva = isNaN(iva) ? 0 : iva;
			      	subtotal += (costo - iva);
			      	total_iva += iva;
			      	total += costo;
			      	if (($('td.iva-p input', this).val()) == '10'){
			      		iva10 += iva;
			      	}else{
			      		iva5 += iva;
			      	}
		    	});
			    $('div.subtotal').text(subtotal.toFixed(0));
			    $('div.total-iva').text(total_iva.toFixed(0));
			    $('div.total').text(total);
			    $('div.iva5').text(iva5.toFixed(0));
			    $('div.iva10').text(iva10.toFixed(0));

			    $('.total-f').val(total);
			    $('.total-i').val(total_iva.toFixed(0));

			    facturasCompraUI.formatearMontos();
		  	});

		  	//Al cambiar cantidad, multiplica por precio y actualiza total
		  	$('td.cantidad input').keyup(function(){
		    	var subtotal = 0;
		    	var total = 0;
		    	var total_iva = 0;
		    	var iva5 = 0;
		    	var iva10 = 0;
		    	$('table tbody tr').each(function() {
		      		var precio = parseInt($('td.precio', this).text().replace(/^[^\d.]*/, ''));
		      		var cantidad = parseInt ($('td.cantidad input', this).val());
		      		var costo = cantidad * precio;
		      		$('td.costo', this).text(costo);
		      		var iva_p = ($('td.iva-p input', this).val()) / 100;
		      		var iva = iva_p * costo;
		      		$('td.iva', this).text(iva.toFixed(0));
		      		costo = isNaN(costo) ? 0 : costo;
		      		iva = isNaN(iva) ? 0 : iva;
		      		subtotal += (costo - iva);
		      		total_iva += iva;
		      		total += costo;
		      		if  (($('td.iva-p input', this).val()) == '10'){
			      		iva10 += iva;
			      	}else{
			      		iva5 += iva;
			      	}
		    	});
			    $('div.subtotal').text(subtotal.toFixed(0));
			    $('div.total-iva').text(total_iva.toFixed(0));
			    $('div.total').text(total);
			    $('div.iva5').text(iva5.toFixed(0));
			    $('div.iva10').text(iva10.toFixed(0));

			    $('.total-f').val(total);
			    $('.total-i').val(total_iva.toFixed(0));

			    facturasCompraUI.formatearMontos();
		  	});

		   	$(function() {
		    	$('.datepicker').datepicker();
		  	});

		   	//Valida el formulario antes de enviarlo
		  	$('form').validate({
				rules: {
		           "factura_compra[numero]": {required: true, numberDocCom: true, remote: "/facturas_compra/check_numero" }
				}
			});

		  	//Evita enviar un componente cuya cantidad sea cero
		  	$('input[type="submit"]').click(function(e){
		  		$('table tbody tr').each(function() {
		  			var cantidad = parseInt ($('td.cantidad input', this).val());
		  			if (cantidad == 0){
		  				$(this).remove();
		  			}
		  		});
    			$(this).parents('form').submit();
    			e.preventDefault();
  			});
		}
	};
}());

$(function(){
	facturasCompraUI.init();
});