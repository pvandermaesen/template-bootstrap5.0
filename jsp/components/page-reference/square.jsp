<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib
	prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><c:if
	test="${fn:length(pages)>0}">
	<c:if test="${not empty param.shortList}">
		<div class="short">
	</c:if>	
	<c:if test="${not empty firstPage}">
		<div class="first-page-complete">${firstPage}</div>
	</c:if>	
	<c:if test="${not empty title}"><h2>${title}</h2></c:if>
	<ul class="products square">
		<c:forEach items="${pages}" var="page" varStatus="status">
			<c:set var="image" value="${null}" />
			<c:if test="${fn:length(page.images)>0}">
				<c:set var="image" value="${page.images[0]}" />
			</c:if>
			<!-- portfolio item -->
			<li class="item-${status.index+1}"><div class="in-wrapper"><c:if test="${not empty image}">				
					<figure>
						<a title="${page.title}" href="${page.url}"> <img src="${image.url}" class="frame" alt="${image.description}" /> </a>
					</figure>
				</c:if>
				<div class="caption">
					<c:if test="${globalContext.collaborativeMode && not empty page.creator}">
						<div class="authors">${page.creator}</div>
					</c:if>
					<c:if test="${page.contentDate}"><span class="date">${page.date}</span></c:if><h3><a title="${page.title}" href="${page.url}">${page.title}</a></h3>
					<c:if test="${not empty page.description && empty param.shortList}">
						<p class="description">${page.description}</p>
					</c:if>
				</div></div></li>
			<!-- / portfolio item -->

		</c:forEach>
	</ul>
	<c:if test="${not empty param.shortList}">
		</div>
	</c:if>
</c:if>