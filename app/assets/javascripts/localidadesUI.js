var localidadesUI = (function(){

	function formatResults(c){
		var markup = ['<li class="ciudad-result">'];
		markup.push(c.nombre);
		markup.push('</br>'+c.estado.nombre);
		markup.push('</li>');
		return markup.join('');
	}

	function formatSelectionClient(c){
		//$('#client_id').val(client.id);
		//console.log(client.id);
		return c.nombre;
	}

	return {
		recargarEstadosSelect: function(paisId, target){
			$.ajax({
				url: 'localidades/'+paisId+'/get_estados',
				type: 'post',
				dataType: 'json',
				data: {json: true},
				success: function(data){
					recargarSelect(data, target);
				}
			});
		},

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

		editarLocalidad: function(tipo, id){
			$.ajax({
				url: '/localidades/'+ id + '/editar',
				type: 'post',
				data: {tipo_localidad: tipo},
				dataType: 'html',
				success: function(response){
					var form = $('#item-' + tipo + '-' + id);
					form.find('.localidad-item').switchClass('show','hide');
					form.append(response).expose({
						onClose: function(){
							form.find('.localidad-form').remove();
							form.find('.localidad-item').switchClass('hide','show');
						}
					});
				}
			});
		},

		initCiudadSelect: function(){
			$('#provider_ciudad_id').select2({
				placeholder: 'busque la ciudad',
				minimumInputLength: 2,
				ajax: {
					url: '/localidades/buscar_ciudades',
					type: 'post',
					datatype: 'jsonp',
					data: function(term,page){
						return {
							term: term
						};
					},
					results: function(data,page){
						return { results: data };
					}
				},
				formatResult: formatResults,
				formatSelection: formatSelectionClient,
				escapeMarkup: function(c) { return c; }
			});
		},

		init: function(){
			$('body').on('click', '.cancelar-edicion', function(e){
				var form = $(this).parents('.localidad-wrap');
				form.find('.localidad-form').switchClass('show','hide');
				form.find('.localidad-item').switchClass('hide','show');
				$.mask.close();

				e.stopPropagation();
				e.preventDefault();
			});

			$('body').on('click', '.reload-column', function(e){
				localidadesUI.recargarLista($(this).data('tipo'), '/localidades/'+$(this).data('id'));
				e.preventDefault();
			});

			$('body').on('change', '.recargar-estados', function(e){
				localidadesUI.recargarEstadosSelect($(this).val(), $(this).parents('form').find('#ciudad_estado_id'));
			});

			$('body').on('click', '.editar-localidad', function(e){
				localidadesUI.editarLocalidad($(this).data('tipo'), $(this).data('id'));

				e.stopPropagation();
				e.preventDefault();
			});
		}

	};
}());

$(function(){
	localidadesUI.init();
});