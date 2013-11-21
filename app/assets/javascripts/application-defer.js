// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//= require vendor/jquery.spin.min
//= require modules/localidadesUI
//= require modules/pedidosCotizacionUI
//= require modules/facturasCompraUI
//= require modules/pedidosCompraUI
//= require modules/ordenesCompraUI
//= require modules/ordenesDevolucionUI
//= require modules/depositosUI
//= require modules/asientosContableUI
//= require modules/cuentasContableUI
//= require modules/notasDebitoCompraUI
//= require modules/notasCreditoCompraUI
//= require modules/auditoriaUI
//
$(function(){
	// Inicializar el validador para los formularios cuando se abre un modal
	$('#add-modal').on('show.bs.modal', function(){
		$(this).find('form').validate();
	});

	// Evento para cerrar el side form
	$('body').on('click', '.close-add-form', function(e){
		SideFormUI.closeForm();
		e.preventDefault();
	});

	// Inicializar tooltip
	$('body').tooltip({
      selector: '[data-toggle=tooltip]'
    });

	// Evento para imprimir listado actual
    $('body').on('click', '.listado-actual', function(e){
		$('#printable').html($('#list table').clone());
		window.print();
		e.preventDefault();
    });

    // Evento para mostrar el formulario de filtros
    $('.filtrar-link').click(function(e){
		$(this).parents('.form-search').hide().next('.form-filtrar').addClass('show');
		e.preventDefault();
    });

    // Evento para esconder el formulario de filtros
    $('.esconder-filtros').click(function(e){
		$(this).parents('.form-filtrar').removeClass('show').prev('.form-search').show();
		e.preventDefault();
    });

    $('body').on('reset', '.form-filtrar', function(e){
    	//Limpiar select al resetear el fomulario de filtros.
    	$(this).find('select').val('').trigger('change');
    });

    $('#toggle-sidebar').on('click', function(e){
    	if($(this).data('status') == 'closed'){
    		$('#sidebar-menu').removeClass('hidden-sidebar', 500, 'swing');
    		$('#content-wrapper').removeClass('hidden-sidebar', 500, 'swing');
    		$(this).data('status', 'open').find('i').removeClass('icon-chevron-right');
    	}else{
    		$('#sidebar-menu').addClass('hidden-sidebar', 500, 'swing');
    		$('#content-wrapper').addClass('hidden-sidebar', 500, 'swing');
    		$(this).data('status', 'closed').find('i').addClass('icon-chevron-right');
    	}
    	e.preventDefault();
    });

    // Agregar el icono para limpiar campos
    $('.has-clear').clearInput();

    // Inicializar datepicker
    $('.datepicker').datepicker();

    //Limpiar campos y limitaciones
    //$('.num-doc-com').inputmask('Regex', { regex: "[0-9\-\.]{15}" });
  	$('.num-doc-com').clearInput();
  	$('.num-doc-com').validCampoFranz('0123456789-/.');

});

var SideFormUI = (function(){
	return{
		showForm: function(){
			$('#sideForm-backdrop').switchClass('hide','show', 500, 'swing');
			$('#add-form').addClass('side-form-show', 500, 'swing');
			$('#add-form').find('form').validate();
		},
		closeForm: function(){
			$('#add-form').removeClass('side-form-show', 500, 'swing');
			$('#sideForm-backdrop').switchClass('show', 'hide', 500, 'swing');
		}
	};
}());

// Para que el formulario de busqueda actualize a medida que se tipea
$('.buscador:first').keyup(function () {
	delay(function(){
		$('.buscador').submit();
	}, 500);
});

var delay = (function(){
  var timer = 0;
  return function(callback, ms){
    clearTimeout (timer);
    timer = setTimeout(callback, ms);
  };
})();

jQuery.fn.numberOnly = function(){
   $(this[0]).keypress(function(event){
    	if (event.which && (event.which < 48 || event.which > 57)) {
      		event.preventDefault();
    	}
 	});
};

function recargarSelect(map, target){
	var options = [];
	$.each(map, function(i, val){
		options.push('<option value="'+val[0]+'">'+val[1]+'</option>');
	});
	target.html(options.join(''));
}

