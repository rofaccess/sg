// Configuraciones generales para las validaciones
jQuery.validator.setDefaults({
	errorElement:	'span',
	errorClass:		'text-warning',
	highlight: function(element){
		$(element).closest('.form-group').addClass('has-warning');
	},
	success: function(element){
		$(element).closest('.form-group').removeClass('has-warning');
	}
});


// Reglas para las validaciones
$.validator.addClassRules({
	required: {
		required: true
	},
	shortString: {
		maxlength: 50
	},
	mediumString: {
		maxlength: 150
	},
	longString: {
		maxlength: 250
	},
	numberDocCom: {
		maxlength: 15
	},
	cantidadDocCom: {
		maxlength: 5
	}
});
