;(function ($, window, document, undefined) {
	
	var HAS_CHILDREN_LINKS = '<a class="tree-command icon" href="#"><i class="fas fa-plus-circle open-command" aria-hidden="true"></i><i class="fas fa-minus-circle close-command" aria-hidden="true"></i></a>';
	var NO_CHILDREN_LINKS = '<a class="tree-command icon" href="#"><i class="fas fa-arrow-circle-right open-command" aria-hidden="true"></i><i class="fas fa-arrow-circle-down close-command" aria-hidden="true"></i></a>';
	var NO_LINKS = '<span class="icon" href="#"><i class="fas fa-angle-right open-command" aria-hidden="true"></i></span>';

	$.fn.treeview = function() {		
	    $(this).find('li').each(function() {
	    	if ($(this).find('ul').length > 0) {
	    		$(this).prepend(HAS_CHILDREN_LINKS);
	    	} else if ($(this).find('.info-wrapper').length > 0) {
	    		$(this).prepend(NO_CHILDREN_LINKS);
	    	} else {
	    		$(this).prepend(NO_LINKS);
	    	}
	    });
	    $('.tree-command').click(function() {
	    	var block = $(this).parent(); 
	    	if (block.hasClass('block-close')) {
	    		block.removeClass('block-close');
	    		block.addClass('block-open');
	    	} else {
	    		block.addClass('block-close');
	    		block.removeClass('block-open');	    		
	    	}
			return false;
	    });
	};	

})(jQuery, window, document);
