<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"
%>
<c:set var="localCompId" value="${compid}" />
<c:if test="${fn:length(pages)>0}"><div id="carousel-${localCompId}" class="owl-carousel-wrapper ${param.caption?'with-caption':'without-caption'}">
<c:if test="${not empty title}"><h2>${title}</h2></c:if>
<div class="owl-carousel owl-theme ">
	<c:set var="active" value=' active' />
  	<c:forEach items="${pages}" var="page" varStatus="status">
		<c:if test="${fn:length(page.images)>0}">
			<c:set var="image" value="${page.images[0]}" />
			<div class="item${active}">
				<c:set var="active" value='' />
				<jv:changeFilter var="newURL" url="${image.url}" filter="reference-list" newFilter="slide" />
				<jv:changeFilter var="smURL" url="${image.url}" filter="reference-list" newFilter="slide-sm" />
				<picture>
					<source media="(max-width: 767px)" srcset="${smURL}" />
					<img class="d-block w-100" alt="${page.title}" src="${newURL}" />
				</picture>
				<a class="caption" href="${page.url}">
					<h2>${page.title}</h2>
					<c:if test="${not empty page.description && page.description != 'no desc'}"><p>${page.description}</p></c:if>  			  
				</a>
			</div>
		</c:if>
	</c:forEach>	
  </div>
  <div class="captions">
		<c:set var="c" value='1' />
		<c:forEach items="${pages}" var="page">
			<c:if test="${fn:length(page.images)>0}">
				<a class="out-caption${c==1?' active':''} out-caption-${c}" href="${page.url}" onmouseover="mouseoverOwl${localCompId}(${c-1});">
					<div class="in-wrapper">
						<h2>${page.title}</h2>
					</div>
				</a>
				<c:set var="c" value='${c+1}' />
			</c:if>
		</c:forEach>
	</div>
</div>
<script>
function mouseoverOwl${localCompId}(index) {
	console.log(index);
	if (window.jQuery) {
		var owl = $('#carousel-${localCompId} .owl-carousel');
		owl.trigger('to.owl.carousel', [index]);
		owl.trigger('stop.owl.autoplay');
	}
}	
function initOwl${localCompId}() {
	var owl = $('#carousel-${localCompId} .owl-carousel');
	owl.owlCarousel({
		loop:true,
		autoplay:true,
		autoplayHoverPause:true,
		URLhashListener:true,
		margin:1,
		nav:false,
		dots:false,
		items:1
	});
	owl.on('changed.owl.carousel', function(event) {
		var index = event.item.index;
		var count = event.item.count;
		index = Math.trunc(index - count/2)+1;
		if (index > count) {
			index -= count;
		}
		if (index <= 0) {
			index += count;
		}
		$('#carousel-${localCompId} .out-caption').removeClass("active");
		$('#carousel-${localCompId} .out-caption-'+(index)).addClass("active");
	});
}
if (window.jQuery) {
	initOwl${localCompId}();
} else {
	document.addEventListener("DOMContentLoaded", function(event) {initOwl${localCompId}();});
}
</script></c:if>