onThumbnailsClick = function(e) {
	e = e || window.event;
	e.preventDefault ? e.preventDefault() : e.returnValue = false;
	eTarget = e.target || e.srcElement;
	eTarget=eTarget.parentElement;		
	openPhotoSwipe( parseInt(eTarget.dataset.initindex), eTarget.items);
	return false;
};

openPhotoSwipe = function(inIndex, items) {		
	options = {    
		history: false,
		focus: false,
		bgOpacity: 0.8,
		showAnimationDuration: 0,
		hideAnimationDuration: 0,
		index: inIndex
	};
	var photoSwipe = new PhotoSwipe( document.querySelectorAll('.pswp')[0], PhotoSwipeUI_Default, items, options);
	photoSwipe.init();
	document.photoSwipe = photoSwipe;
};

getImageSizeWidth = function(link) {
	if (link.dataset.width!=null) {
		return link.dataset.width;
	}
	img = link.querySelector("img");
	if (img != null) {
		if (img.hasOwnProperty('naturalWidth')) {
			return img.naturalWidth;
		} else {
			if (img.width<800) {
				return 800;
			}
			return img.width;
		}
	}
}

getImageSizeHeigth = function(link) {
	if (link.dataset.height!=null) {
		return link.dataset.height;
	}
	img = link.querySelector("img");
	if (img != null) {
		if (img.hasOwnProperty('naturalHeight')) {
			return img.naturalHeight;
		} else {
			if (img.width<800) {
				return 800*(img.height/img.width);
			}
			return img.height;
		}
	}
}

getTitle = function(link) {
	if (link.dataset.caption != null) {
		return link.dataset.caption;
	} else if (link.getAttribute("title") != null) {
		return link.getAttribute("title"); 
	} else {
		return "";
	}
}

var removeParam = function( url ) {
    if (url.indexOf('?')>=0) {
        return url.substring(0,url.indexOf('?'));
    } else {
        return url;
    }
}


var initPhotoSwipeFromDOM = function(selector) {	
	var pswpElement = document.querySelectorAll('.pswp')[0];
	
	var galleryElements = document.querySelectorAll( selector );
	var items = [];
    for(var i = 0, l = galleryElements.length; i < l; i++) {
    	var href=galleryElements[i].getAttribute('href');
    	
    	if(/\.(?:jpg|jpeg|gif|png|pdf)$/i.test(removeParam(href))){
    		galleryElements[i].setAttribute("data-initindex", i);
    		galleryElements[i].onclick = onThumbnailsClick;		
    		galleryElements[i].items = items;		
    		items[i] = {el:galleryElements[i],src:galleryElements[i].getAttribute('href'),w:getImageSizeWidth(galleryElements[i]) ,h:getImageSizeHeigth(galleryElements[i]), title:getTitle(galleryElements[i])};
    	}
    }
};


