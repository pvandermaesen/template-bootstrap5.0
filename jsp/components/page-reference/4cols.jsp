<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib
prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"
%><c:if test="${not empty title}"><h2>${title}</h2></c:if>
<c:set var="size" value="${not empty param.colsize?param.colsize:4}" />
<c:set var="colClass" value="col-md-3 col-sm-6" />
<c:set var="imageFilter" value="card" />
<c:choose>
	<c:when test = "${size ==  1}">
		<c:set var="imageFilter" value="full" />
		<c:set var="colClass" value="col-12" />
	</c:when>
	<c:when test = "${size ==  2}">
		<c:set var="colClass" value="col-sm-6" />
	</c:when>
	<c:when test = "${size ==  3}">
		<c:set var="colClass" value="col-sm-4" />
	</c:when>
	<c:when test = "${size ==  6}">
		<c:set var="colClass" value="col-6 col-sm-4 col-lg-2" />
	</c:when>
</c:choose>
<div class="row cols-list cols${size} ${param.cssClass} cols"><c:forEach items="${pages}" var="page" varStatus="status">
	<div class="${colClass} page-item  ${status.index%2==0?'odd':'even'}">
		<a href="${page.linkOn}" class="card${popup?' popup':''}">
			<c:if test="${fn:length(page.images)>0}">
				<c:set var="image" value="${page.images[0]}" />		
				<jv:changeFilter var="newURL" url="${image.url}" filter="reference-list" newFilter="${imageFilter}" />	
				<img class="card-img-top" src="${newURL}" alt="" />
			</c:if> 
			<div class="card-body">
				<c:if test="${page.contentDate}"> <p class="card-text"><small class="text-muted date">${page.contentDateValue}</small></p></c:if>
				<h5 class="card-title">${page.title}</h5>
				<c:if test="${not empty page.description && page.description != 'no desc'}">
				<p class="card-text"><span class="text">${page.description}</span></p>
				</c:if>
				<c:if test="${fn:length(page.taxonomy)>0}"> <p class="card-text"><small class="text-muted taxonomy">
					<c:set var="sep" value="" />
					<c:forEach var="taxonomyItem" items="${page.taxonomy}">
						<span class="item"><span class="sep">${sep}</span><span class="text">${taxonomyItem.label}</span>
						<c:set var="sep" value=", " />
					</c:forEach>
				</small></p></c:if>
				
			</div> 
		</a>
	</div>
	<c:if test="${status.count % size == 0 && status.count>1}"></div><div class="row cols-list cols${size} ${param.cssClass}"></c:if>
	</c:forEach>
</div>
