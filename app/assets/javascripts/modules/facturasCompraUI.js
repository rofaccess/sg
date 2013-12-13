var facturasCompraUI = (function(){
	return {
		cargarOrdenesDetalles: function(url, id, replace){
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
			$('body').on('change', '#orden_compra_id', function(e){
				facturasCompraUI.cargarOrdenesDetalles('facturas_compra/get_orden_compra', $(this).val(), '#main-modal .detalles-orden-compra');
			});

			$('body').on('click', '.recargar_orden', function(e){
				facturasCompraUI.cargarOrdenesDetalles('facturas_compra/get_orden_compra', $('#orden_compra_id').val(), '#main-modal .detalles-orden-compra');
				$('.detalles-orden-compra').removeClass('hide');
				$('.detalles-orden-compra').addClass('show');
				$('.recargar-warning').removeClass('show');
				$('.recargar-warning').addClass('hide');
			});

			$('body').on('click', '.show-factura', function(e){
				$.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
			});

			// Evento para remover un detalle de una factura en la pantalla de generar factura de compra
			$('body').on('click', '.remover-detalle-factura', function(e){
				$(this).parents('tr.factura-detalle').remove();
				if($('.factura-detalle').length == 0){
					$('.detalles-orden-compra').removeClass('show');
					$('.detalles-orden-compra').addClass('hide');
					$('.recargar-warning').removeClass('hide');
					$('.recargar-warning').addClass('show');
				}else{
					//Al borrar la fila recalcula los montos
					facturasCompraUI.calcularFormatearMontos();
				}
				e.preventDefault();
			});

			facturasCompraUI.formatearMontos();

			$('body').on('click', '.imprimir-facturas-compra', function(e){
				$.ajax({
					url: $(this).attr('href'),
					data: $('#factura_compra_search.form-filtros').serialize(),
					dataType: 'script'
				});
				e.preventDefault();
			});
		},

		// Calcula y formatea los montos una vez
		calcularFormatearMontos: function(){
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
			      	var iva = (costo / (iva_p + 1)) * iva_p;
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
			    $('td.subtotal').text(subtotal.toFixed(0));
			    $('td.total-iva').text(total_iva.toFixed(0));
			    $('td.total').text(total);
			    $('td.iva5').text(iva5.toFixed(0));
			    $('td.iva10').text(iva10.toFixed(0));

			    $('.total-f').val(total);
			    $('.total-i').val(total_iva.toFixed(0));

			    facturasCompraUI.formatearMontos();
		},

		//Todos los montos  se formatean como moneda
		formatearMontos: function(){
			$('.monto').each(function() {
				$(this).text().replace(/^[^\d]*/, '');
    			$(this).number( true, 0,  ',', '.' );
    			var monto = $(this).text();
    			$(this).text($('.simbolo_moneda').text()+ ' ' + monto);
  			});
		},

		//Al cambiar cantidad, multiplica por precio y actualiza total
		onChangeCantidad: function(){
			$('td.cantidad input').keyup(function(){
		    	var subtotal = 0;
		    	var total = 0;
		    	var total_iva = 0;
		    	var iva5 = 0;
		    	var iva10 = 0;
		    	$('table tbody tr').each(function() {
		      		var precio = parseInt($('td.precio', this).text().replace(/^[^\d.]*/, ''));
		      		var cantidad = parseInt ($('td.cantidad input', this).val());
		      		var faltante = parseInt ($('td.faltante', this).text());
		      		if ((cantidad > faltante)||(cantidad < 1)) {
		      			cantidad = faltante;
		      			$('td.cantidad input', this).val(cantidad);
		      		}
		      		var costo = cantidad * precio;
		      		$('td.costo', this).text(costo);
		      		var iva_p = ($('td.iva-p input', this).val()) / 100;
		      		var iva = (costo / (iva_p + 1)) * iva_p;
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
			    $('td.subtotal').text(subtotal.toFixed(0));
			    $('td.total-iva').text(total_iva.toFixed(0));
			    $('td.total').text(total);
			    $('td.iva5').text(iva5.toFixed(0));
			    $('td.iva10').text(iva10.toFixed(0));

			    $('.total-f').val(total);
			    $('.total-i').val(total_iva.toFixed(0));

			    facturasCompraUI.formatearMontos();
		  	});
		},

		//Esconde plazo de pago cuando condicion es contado, muestra si es credito
		escondeMuestraPlazoPago: function(){
			//Esconde el plazo de pago
		    $('.to-hide').hide();
		    //Desactiva el select de plazos de pago
		    $('#factura_compra_plazo_pago_id').attr("disabled",true);
		    //Remueve opciones vacias
		    //$("#factura_compra_condicion_pago_id option:selected").remove();
		    //$("#factura_compra_plazo_pago_id option:selected").remove();
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
		},

		// Metodo para get orden de compra
		initInGetOrdenCompra: function(){

		  	facturasCompraUI.escondeMuestraPlazoPago();

		  	// En los campos input de cantidad se ignoran los valores que no sean numericos
		  	$('td.cantidad input').numberOnly();

		  	facturasCompraUI.calcularFormatearMontos();

		  	facturasCompraUI.onChangeCantidad();

		  	// Facilita seleccionar una fecha
		   	$(function() {
		    	$('.datepicker').datepicker();
		  	});

		   	// Valida el formulario antes de enviarlo
		  	$('#new_factura_compra').validate();
		}
	};
}());

$(function(){
	facturasCompraUI.init();
});