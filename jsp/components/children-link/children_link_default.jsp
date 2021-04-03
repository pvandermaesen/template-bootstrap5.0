<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><c:if test="${fn:length(children)>0}">
<c:if test="${not empty title}">
	<h2>${title}</h2>
</c:if>


<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarChildrenLink${compid}" aria-controls="#navbarChildrenLink${compid}" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="#navbarChildrenLink${compid}">
    <ul class="navbar-nav mr-auto">
    <c:forEach var="child" items="${children}" varStatus="status">
	<li class="${child.selected?'active':'unactive'} ${status.index % 2 == 0?'odd':'even'} nav-item"><a class="${popup?'popup ':''}nav-link${child.selected?' active':''}" href="${child.url}">${child.fullLabel}</a></li>
	</c:forEach>
    </ul>
  </div>
</nav>

</c:if> 