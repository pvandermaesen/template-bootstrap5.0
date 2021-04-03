<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<c:if test="${fn:length(files) > 0}">
<c:forEach var="file" items="${files}">
<div class="card">
<div class="card-header">${file.name}</div>
<div class="card-body">
	<div class="row">
		<div class="col-sm-4">
			<c:if test="${!file.video}">
				<a href="${file.URL}" target="_blank">
				<figure class="img-thumbnail">
					<img class="img-fluid" src="${file.thumbURL}" alt="preview of ${file.name}" lang="en" />
				</figure>
				</a>
			</c:if>
			<c:if test="${file.video}">
					<!-- "Video For Everybody" http://camendesign.com/code/video_for_everybody -->
					<video controls="controls">
					<source src="${file.absoluteURL}" type="video/mp4" />					
					</video>
			</c:if>
		</div><div class="col-sm-8">
			<div class="list-group">
  				<div class="list-group-item">
					<div class="d-flex w-100 justify-content-between">
    					<h5 class="mb-1">${file.title}</h5>
						<small>${file.date}</small>
					</div>
    				<c:if test="${not empty file.description}"><p class="mb-1">${file.description}</p></c:if>
    				<small>${file.type} - ${file.size}</small>
  				</div>
  				<a href="${file.URL}" target="_blank" class="list-group-item list-group-item-action active text-center">
     				<h5 class="mb-1">${i18n.view[('global.download')]}</h5>
  				</a>
			</div>
		</div>
	</div>
</div>
</div>
</c:forEach>
</c:if>