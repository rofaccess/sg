var localidadesUI = (function(){
	return {
		recargarLista: function(tipo, domain){
			var url = '';
			var columna = '';
			var data = {};

			if (tipo === 'pais') {
				url = domain + '/get_paises';
				columna = 'paises-lista';
			}else if (tipo === 'estado') {
				url = domain + '/get_estados';
				columna = 'estados-lista';
			}else if(tipo === 'ciudad'){
				url = domain + '/get_ciudades';
				columna = 'ciudades-lista';
			}

			$.ajax({
				url: url,
				type: 'post',
				dataType: 'html',
				data: data,
				beforeSend: function(){
					var sp = showSpinner(columna);
				},
				success: function(response){
					$('#'+columna).html(response);
				}
			});
		},

		init: function(){
			$('body').on('click', '.reload-column', function(e){
				localidadesUI.recargarLista($(this).data('tipo'), '/localidades/'+$(this).data('id'));
				e.preventDefault();
			});
		}

	};
}());

$(function(){
	localidadesUI.init();
});