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
//
$(function(){
	$('#add-modal').on('show.bs.modal', function(){
		$(this).find('form').validationEngine({promptPosition: 'topRight'});
	});

	$('#add-form').find('form').validationEngine({promptPosition: 'topLeft'});



	$('body').on('click', '.close-add-form', function(e){
		console.log('ee');
		SideFormUI.closeForm();
		e.preventDefault();
	});

});
var SideFormUI = (function(){
	return{
		showForm: function(){
			$('#add-form').addClass('side-form-show', 500, 'swing');
			$('#add-form').find('form').validationEngine({promptPosition: 'topLeft'});
		},
		closeForm: function(){
		$('#add-form').removeClass('side-form-show', 500, 'swing');

		}
	};
}());