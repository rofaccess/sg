/*
 * PLugin para agregar un icono a los inputs para limpiar el campo.
 * uso: $(elemento).clearInput();
 */
(function ($) {
	$.fn.clearInput = function(options){
		// Opciones
		var settings = $.extend({}, options);

		//Funcion que agrega un icon al lado del input
		function addIcon (field, icon) {
			if(field.prev('.icon-remove').length == 0){
				field.before(icon);
				attachClearEvent(icon);
			}
		}
		// Funcion para registrar el evento click para limpiar el campo
		function attachClearEvent (icon) {
			icon.on('click', function(e){
				$(this).next('input').val('').prop('defaultValue', '');
				e.stopPropagation()
				e.preventDefault();
			});
		}

		// Inicializar cada input
		return this.filter('input').each(function(){
			var icon = $('<i class="icon-remove limpiar-campo"></i>');
			addIcon($(this), icon);
		});
	};
}(jQuery));