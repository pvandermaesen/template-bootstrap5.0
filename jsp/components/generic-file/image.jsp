<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"%><c:if test="${empty url}">need file...</c:if>
<jv:changeFilter var="newURL" url="${imagePreview}" filter="list" newFilter="height-8" />
<div ${previewAttributes}>
<a href="${url}" ${globalContext.openFileAsPopup?' target="_blank"':''}><img src="${newURL}" class="w-100" alt="${label}" /></a>
</div>