var depositosUI = (function(){
	return {
		init: function(){
			$('body').on('click', '.show-deposito', function(e){
				$.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
			});

			$('body').on('click', '.imprimir-depositos', function(e){
				$.ajax({
					url: $(this).attr('href'),
					data: $('#deposito_search.form-filtros').serialize(),
					dataType: 'script'
				});
				e.preventDefault();
			});
		}

	};
}());

$(function(){
	depositosUI.init();
});