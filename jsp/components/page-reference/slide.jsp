<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"
%><c:if test="${fn:length(pages)>0}"><div id="carousel-${compid}" class="slide ${param.caption?'with-caption':'without-caption'}">
<c:if test="${not empty title}"><h2>${title}</h2></c:if>
<div class="owl-carousel owl-theme">
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
</div>

<script>
function initOwl${compid}() {
	$('#carousel-${compid} .owl-carousel').owlCarousel({
		loop:true,
	    autoplay:true,
	    autoplayHoverPause:true,
	    margin:1,
	    nav:true,
	    dots:false,
	    responsiveClass:true,
	    items:1
	});
}
if (window.jQuery) {
	initOwl${compid}();
} else {
	document.addEventListener("DOMContentLoaded", function(event) {initOwl${compid}();});
}
</script>
</c:if>