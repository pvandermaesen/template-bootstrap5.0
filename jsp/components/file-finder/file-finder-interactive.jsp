<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<div class="card">
<div class="card-body">
<form id="file-finder-form-${compid}" method="post" action="${info.currentURL}">
<div class="file-finder-form">
	
	<c:if test="${not empty taxonomies}">
	<div class="form-group row">
	    <label for="taxonomy-select-${compid}" class="col-sm-2 col-form-label col-form-label-sm">${i18n.view['component.file-finder.taxonomy']}</label>
	    <div class="col-sm-10">
	    <select onchange="this.form.submit();" id="taxonomy-select-${compid}" name="taxonomy" data-placeholder="${i18n.view['global.choose']}" class="chosen-select form-control" multiple="multiple">
		    <c:forEach var="taxonomy" items="${taxonomies}">
				<c:forEach var="item" items="${taxonomy.allChildren}">
					<option value="${item.id}" ${fn:contains(fn:join(paramValues.taxonomy, ","), item.id)?'selected="selected"':''}>${item.pathLabel}</option>
				</c:forEach>
			</c:forEach>
		</select>
	    </div>
	</div>
	</c:if>
	<div class="form-group row">
	    <label for="freetext-${compid}" class="col-sm-2 col-form-label col-form-label-sm">${i18n.view['global.text']}</label>
	    <div class="col-sm-10">
	    	<input id="freetext-${compid}" type="text" name="text" class="form-control" value="${param.text}" />
	    </div>	    
	</div>
	<div class="form-group row">
	    <div class="col-sm-2">&nbsp;</div>
	    <div class="col-sm-8">
	    	<div class="form-group form-check">
    			<input type="checkbox" class="form-check-input" id="max" name="max" value="100" ${param.max=="100"?'checked="checked"':''} />
    			<label class="form-check-label" id="max">${vi18n['component.file-finder.display.100']}</label>
  			</div>
	    </div>
	    <div class="col-sm-2 text-right">
	    <button type="submit" class="btn btn-primary btn-md">${i18n.view['global.search']}</button>
	    </div>
	</div>	
	 
</div>
</form>
</div></div>

<c:if test="${fn:length(files) == 0 && (filter.active || display)}">
<div class="alert alert-warning mt-3 mb-3">${vi18n['global.no-result']}</div>
</c:if>
<c:if test="${fn:length(files) > 0}">

<table class="table table-striped table-bordered table-sm mt-3 mb-3">
<thead>
	<tr>
		<th>${vi18n['component.file-finder.title.preview']}</th>
		<th>${vi18n['component.file-finder.title.name']}</th>
		<th>${vi18n['component.file-finder.title.title']}</th>
		<th>${vi18n['component.file-finder.title.date']}</th>
		<th>${vi18n['component.file-finder.title.author']}</th>
		<th>${vi18n['component.file-finder.title.size']}</th>
		<th>${vi18n['component.file-finder.title.description']}</th>
	</tr>
</thead>

<tbody>
<c:forEach var="file" items="${files}">
	<tr>
		<td>
			<c:if test="${!file.video}">
				<a href="${file.URL}" target="_blank">
				<figure>
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
		</td>
		<td class="align-middle"><a href="${file.URL}" target="_blank">${file.name}</a></td>
		<td class="align-middle">${file.title}</td>
		<td class="align-middle">${file.date}</td>
		<td class="align-middle">${file.authors}</td>
		<td class="align-middle">${file.size}</td>
		<td class="align-middle"><small>${file.description}</small></td>
	</tr>
</c:forEach>
</tbody>
</table>
</c:if>