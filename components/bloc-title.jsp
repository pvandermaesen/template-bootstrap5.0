<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"
%><c:if test="${empty countInfoBloc}"><c:set var="countInfoBloc" value="0" /></c:if>
<c:set var="countInfoBloc" value="${countInfoBloc+1}" />
<c:set var="cssStyle" value="" />
<c:if test="${not empty color.value}">
	<c:set var="cssStyle" value='style="background-color:${color.value}"' />
</c:if>
<div class="item col-${width.value<3?'lg':'md'}-${width.value} ${not empty imagehover.previewURL || blackwhite.value?'hover-bloc':''} ${!nextSame?'last':''} ${!previousSame?'first':''} ${arrow.value || arrowActive?'arrow-bloc':'not-arrow-bloc'}">
<div ${previewAttributes}><div class="bloc"><div class="card" ${cssStyle}>

<div class="card-picto-top"><i class="${picto.value}"></i></div>
<div class="card-body">
	<c:if test="${not empty title.value}"><h2 class="card-title">${title.value}</h2></c:if>
	<c:if test="${not empty subtitle.value}"><h3 class="card-title">${subtitle.value}</h3></c:if>
	<c:if test="${not empty text.value}"><p class="card-text">${text.value}</p></c:if>
	${resource.viewXHTMLCode}
</div>
</div></div></div></div>