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
	date: {
		dateITA: true
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
	numFactura: {
		maxlength: 15,
		remote: {
			url: "/facturas_compra/check_numero",
			type: "get",
			data: {
				proveedor_id: function(){
					return $("#factura_compra_proveedor_id").val();
				}
			}
		}
	},
	numNotaPedido: {
		maxlength: 15,
		remote: {
			url: "/notas_debito_compra/check_numero",
			type: "get",
			data: {
				proveedor_id: function(){
					return $("#nota_debito_compra_proveedor_id").val();
				}
			}
		}
	},
	cantidadDocCom: {
		maxlength: 5,
		min: 1
	},
	passwordConfirmation: {
		equalTo: '#user_password'
	}
});

