<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib
prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"
%><c:if test="${not empty title}"><h2>${title}</h2></c:if>
<div class="marketing circle cols3"><div class="row"><c:forEach items="${pages}" var="page" varStatus="status"><div class="col-md-4 text-center item">
	<c:if test="${param.link}">
		<a ${popup?'class="popup" ':''}href="${page.linkOn}">
	</c:if>
	  <c:set var="image" value="${null}" />
	  <c:if test="${fn:length(page.images)>0}">
	     <c:set var="image" value="${page.images[0]}" />
		<jv:changeFilter var="newURL" url="${image.url}" filter="reference-list" newFilter="card" />
		<img src="${newURL}" class="img-circle" alt="" />
	  </c:if>      
      <h2>${page.title}</h2>
      <c:if test="${param.link}">
    	</a>
    </c:if>
      <c:if test="${not empty page.description && page.description != 'no desc'}"><p class="description">${page.description}</p></c:if>
      <c:if test="${page.realContent}"><p class="link"><a class="btn btn-default" href="${page.url}">${not empty page.linkLabel?page.linkLabel:i18n.view['global.moreinfo']}&nbsp;&raquo;</a></p></c:if>
    
    </div>
    <c:if test="${status.count % 3 == 0 && status.count>1}"></div><div class="row"></c:if>
    </c:forEach>
</div></div>
