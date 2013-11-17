var cuentasContableUI = (function(){
	return {
		init: function(){

			$('body').on('click', '.imprimir-cuentas-contable', function(e){
				$.ajax({
					url: $(this).attr('href'),
					data: $('#cuenta_contable_search.form-filtros').serialize(),
					dataType: 'script'
				});
				e.preventDefault();
			});
		}

	};
}());

$(function(){
	cuentasContableUI.init();
});