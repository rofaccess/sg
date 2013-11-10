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
			if(field.next('icon-remove').length == 0){
				field.after(icon);
				attachClearEvent(icon);
			}
		}
		// Funcion para registrar el evento click para limpiar el campo
		function attachClearEvent (icon) {
			icon.on('click', function(e){
				$(this).prev('input').val('');
				e.preventDefault();
			});
		}

		// Inicializar cada input
		return this.filter('input').each(function(){
			var icon = $('<i class="icon-remove limpiar-campo"></i>');
			addIcon($(this), icon);
		});
	};
	$.fn.clearInput2 = function(options){
		// Opciones
		var settings = $.extend({}, options);

		//Funcion que agrega un icon al lado del input
		function addIcon (field, icon) {
			if(field.prev('icon-remove').length == 0){
				field.before(icon);
				attachClearEvent(icon);
			}
		}
		// Funcion para registrar el evento click para limpiar el campo
		function attachClearEvent (icon) {
			icon.on('click', function(e){
				$(this).parent().find('input').val('');
				e.preventDefault();
			});
		}

		// Inicializar cada input
		return this.filter('input').each(function(){
			var icon = $('<i class="icon-remove limpiar-campo2"></i>');
			addIcon($(this), icon);
		});
	};
	$.fn.clearInput3 = function(options){
		// Opciones
		var settings = $.extend({}, options);

		//Funcion que agrega un icon al lado del input
		function addIcon (field, icon) {
			if(field.prev('icon-remove').length == 0){
				field.before(icon);
				attachClearEvent(icon);
			}
		}
		// Funcion para registrar el evento click para limpiar el campo
		function attachClearEvent (icon) {
			icon.on('click', function(e){
				$(this).parent().find('input').val('');
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