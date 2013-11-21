var auditoriaUI = (function(){
	return {
		init: function(){
			$('body').on('click', '.show-detalles-auditoria', function(e){
				$.post($(this).data('url'), { model: {
														model: $(this).data('model'),
														id: $(this).data('model-id'),
														created_at: $(this).data('model-created_at'),
														type_subclase: $(this).data('model-type_subclase')}
											},
											function(){}, 'script');
			});
		}
	};
}());

$(function(){
	auditoriaUI.init();
});