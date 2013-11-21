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
		}

	};
}());

$(function(){
	notasDebitoCompraUI.init();
});