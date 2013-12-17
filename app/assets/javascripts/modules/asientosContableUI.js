var asientosContableUI = (function(){
	return {
		init: function(){

			$('body').on('click', '.imprimir-asientos-contable', function(e){
				$.ajax({
					url: $(this).attr('href'),
					data: $('#asiento_contable_search.form-filtros').serialize(),
					dataType: 'script'
				});
				e.preventDefault();
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
	asientosContableUI.init();
});