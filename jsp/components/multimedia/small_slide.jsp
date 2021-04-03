<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"
%><div class="glide glide-multi" id="glide-${compid}">
	<div class="glide__track" data-glide-el="track">	
		<div class="glide__slides">			  
		  <c:forEach var="resource" items="${resources}" varStatus="status">
				<div class="glide__slide clickable-multimedia">
					<jv:changeFilter var="newURL" url="${resource.previewURL}" filter="preview" newFilter="bloc-2-2" />			 			 						
		     		<a title="${i18n.view['global.enlargeimage']}" class="thumbnail" href="${resource.URL}" rel="${resource.relation}" data-caption="${resource.allInfoText}" data-width="${resource.size.width}" data-height="${resource.size.height}">
		     			<img class="img-responsive" alt="${resource.title} - ${i18n.view['global.enlargeimage']}" src="${newURL}" />
		     		</a>
		     		<c:if test="${not empty resource.title}"> 		
		     		<div class="text">
		     		  <div class="text-wrapper">     		  
		   			  <h${contentContext.titleDepth+1}>${resource.title}</h${contentContext.titleDepth+1}>
		   			  <c:if test="${not empty resource.description}"><p>${resource.description}</p></c:if>
		   			  </div>   			  	   			  
		 			</div>
		 			</c:if>		
		 		</div>	
		  </c:forEach>			  
		</div>
		<div class="glide__arrows" data-glide-el="controls">
			<button class="glide__arrow glide__arrow--left" data-glide-dir="<"><i class="fas fa-angle-left"></i></button>
			<button class="glide__arrow glide__arrow--right" data-glide-dir=">"><i class="fas fa-angle-right"></i></button>
		</div>
	</div>
</div>

<script>
const GLIDE_OPTIONS = {
	perView: 4
}
if (typeof Glide != "undefined") {
	new Glide('#glide-${compid}', GLIDE_OPTIONS).mount();
} else {
	document.addEventListener("DOMContentLoaded", function(event) { 
		new Glide('#glide-${compid}', GLIDE_OPTIONS).mount();
	});
}
</script>