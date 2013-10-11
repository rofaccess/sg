var pedidosCompraUI = (function(){
	return {
		init: function(){
			$('body').on('click', '.show-ped-comp', function(e){
				$.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
			});
		}
	};
}());

$(function(){
	pedidosCompraUI.init();
});