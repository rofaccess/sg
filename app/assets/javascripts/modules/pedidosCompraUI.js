var pedidosCompraUI = (function(){
	return {
		init: function(){
			$('body').on('click', '.show-ped-comp', function(e){
				$.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
			});

			// Evento para remover una cotizacion antes de generar ordenes de compras
			$('body').on('click', '.remover-cotizacion', function(e){
				$(this).parents('.cotizacion-detalles').remove();
				e.preventDefault();
			});

			// Evento para remover un detalle de una cotizacion en la pantalla de generar ordenes de compra
			$('body').on('click', '.remover-detalle-cotizacion', function(e){
				$(this).parents('tr.cotizacion-detalle').remove();
				e.preventDefault();
			});
		},

		// Funcion para registrar evento que muestre/esconda el icono de remove cotizacion
		hoverEventCotizaciones: function(){
			$('.cotizacion-detalles').hover(function(e){
				$(this).find('.remover-cotizacion').switchClass('hide', 'show');
			}, function(e){
				$(this).find('.remover-cotizacion').switchClass('show', 'hide');
			});
		}
	};
}());

$(function(){
	pedidosCompraUI.init();
});