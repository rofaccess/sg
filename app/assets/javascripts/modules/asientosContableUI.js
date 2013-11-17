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
		}

	};
}());

$(function(){
	asientosContableUI.init();
});