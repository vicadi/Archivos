window.addEvent('domready', function() {
	
	//Creación de Un Menú Acordeon
	var myAccordion = new Accordion($('accordion'), 'h3.toggler', 'div.element', {
		opacity: false,
		onActive: function(toggler, element){
			toggler.setStyle('color', '#333333');
		},
		onBackground: function(toggler, element){
			toggler.setStyle('color', '#666666');
		}
	});

});