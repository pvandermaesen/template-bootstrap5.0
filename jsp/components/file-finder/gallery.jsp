<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"%><c:if test="${fn:length(files) > 0}">
<div class="row">
<c:forEach var="file" items="${files}" varStatus="status">
<div class="col-xs-6 col-md-3">
	<a href="${file.URL}" title="${file.title}">
	<figure class="thumbnail">
		<jv:changeFilter var="newURL" url="${file.thumbURL}" filter="list" newFilter="width-4" />
		<img src="${newURL}" alt="preview of ${file.name}" lang="en" />
		<c:if test="${not empty file.title}"><figcaption><h${contentContext.titleDepth+1}>${file.title}</h${contentContext.titleDepth+1}><c:if test="${not empty file.description}"><p>${file.description}</p></c:if></figcaption></c:if>	
	</figure>
	</a>
	<c:if test="${not empty file.translation && fn:length(file.translation)>=1}">
		<div class="btn-group translation" role="group" aria-label="translation">
			<c:forEach var="translation" items="${file.translation}" varStatus="status">
				<a class="btn btn-default btn-xs" href="${translation.URL}" title="${translation.title}">${translation.beanLanguage}</a>
			</c:forEach>
		</div>
	</c:if>	
</div>
<c:if test="${status.count > 1 && status.count % 4 == 0 && !status.last}"></div><div class="row"></c:if>
</c:forEach>
</div>
</c:if>