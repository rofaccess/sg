var notasDebitoCompraUI = (function(){
	return {
		init: function(){
			$('body').on('click', '.imprimir-depositos', function(e){
				$.ajax({
					url: $(this).attr('href'),
					data: $('#deposito_search.form-filtros').serialize(),
					dataType: 'script'
				});
				e.preventDefault();
			});

			$('body').on('click', '.show-nota-d', function(e){
				$.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
			});
		},

		//Todos los montos  se formatean como moneda
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
	notasDebitoCompraUI.init();
});