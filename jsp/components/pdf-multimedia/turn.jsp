<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"
%>
<div id="carousel-${compid}" class="carousel pdf-slide slide" data-ride="carousel"><div class="carousel-inner"><c:forEach var="resource" items="${resources}" varStatus="status">	
	<c:url var="resourceURL" value="${resource.URL}" context="/"></c:url>
	<c:if test="${not empty param.noshadow}">
		<c:url var="resourceURL" value="${info.currentURL}">
			<c:param name="resourceId" value="${resource.id}" />
		</c:url>
	</c:if>
	<c:set var="resourceDescription" value="" />
	<c:if test="${not empty resource.title}">
		<c:set var="resourceDescription" value="${resource.title}" />
		<c:if test="${not empty resource.location}">
			<c:set var="resourceDescription" value="${resourceDescription} - ${resource.location}" />
		</c:if>
		<c:if test="${not empty resource.shortDate}">
			<c:set var="resourceDescription" value="${resourceDescription} - ${resource.shortDate}" />
		</c:if>
	</c:if>
	<div class="carousel-item ${status.index==0?'active':''}">	
	<jv:changeFilter var="newURL" url="${resource.URL}" filter="full" newFilter="width-12" />
	<img class="d-block" src="${newURL}" alt="${resource.title}" />
	</div>
</c:forEach></div>
 <a class="carousel-control-prev carousel-control" href="#carousel-${compid}" role="button" data-slide="prev">
    <i class="fas fa-angle-left" aria-hidden="true"></i>
    <span class="sr-only" lang="en">Previous</span>
  </a>
  <a class="carousel-control-next carousel-control" href="#carousel-${compid}" role="button" data-slide="next">
    <i class="fas fa-angle-right" aria-hidden="true"></i>    
    <span class="sr-only" lang="en">Next</span>
  </a>
</div>

<div class="download-slide text-center mt-3">
	<a class="btn btn-sm btn-secondary" href="${pdfUrl}">${i18n.view['global.download']}</a>
</div>