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
//= require jquery.spin.min
//= require localidadesUI
//
$(function(){
	$('#add-modal').on('show.bs.modal', function(){
		//$(this).find('form').validationEngine({promptPosition: 'topRight'});
	});

	//$('#add-form').find('form').validationEngine({promptPosition: 'topLeft'});

	//$('.add-form').validationEngine({promptPosition: 'bottomLeft'});
	$('body').on('click', '.close-add-form', function(e){
		SideFormUI.closeForm();
		e.preventDefault();
	});
});
var SideFormUI = (function(){
	return{
		showForm: function(){
			$('#add-form').addClass('side-form-show', 500, 'swing');
			$('#add-form').find('form').validate();
			//$('#add-form').find('form').validationEngine({promptPosition: 'bottomLeft',
              //  prettySelect: true,
               // usePrefix: 's2id_'
           // });
		},
		closeForm: function(){
		$('#add-form').removeClass('side-form-show', 500, 'swing');

		}
	};
}());

// Esto es para ke actualize la tabla a medida ke se tipea la buskeda
// Causan muchos problemas
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

function recargarSelect(map, target){
	var options = [];
	$.each(map, function(i, val){
		options.push('<option value="'+val[0]+'">'+val[1]+'</option>');
	});
	target.html(options.join(''));
}

//Lo siguiente aun no esta funcionando
//$(function(){
//	$('#q_name_or_ruc_or_address_or_phone_or_email_cont').searchInput();
//});