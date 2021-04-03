<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><div class="mailing">
<c:if test="${not empty messages.globalMessage.message}">
	<div class="alert alert-${messages.globalMessage.bootstrapType}" role="alert">
		${messages.globalMessage.message}
	</div>
</c:if>
<c:if test="${empty messages.globalMessage || messages.globalMessage.type == 0 || messages.globalMessage.type == 1 || messages.globalMessage.type == 2 || messages.globalMessage.type == 5}">
<form method="post">
<div class="row">
<div class="col-sm-12">
<div class="form-group">
	<input type="hidden" name="comp-id" value="${comp.id}" />
	<input type="hidden" name="webaction" value="mailing-registration.submit" />
	<label for="email">${i18n.view['field.email']}</label>
	<input class="form-control" type="text" name="email" placeholder="${i18n.view['field.email']}" />	
</div></div></div>
<c:if test="${name}">
<div class="row">
<div class="col-sm-6">
<div class="form-group">
	<label for="firstname">${i18n.view['field.firstname']}</label>
	<input class="form-control" type="text" id="firstname" name="firstname" placeholder="${i18n.view['field.firstname']}" />	
</div>
</div><div class="col-sm-6">
<div class="form-group">
	<label for="lastname">${i18n.view['field.lastname']}</label>
	<input class="form-control" type="text" id="lastname" name="lastname" placeholder="${i18n.view['field.lastname']}" />	
</div>
</div></div>
</c:if>
<div class="action">
<input class="btn btn-primary pull-right" type="submit" value="ok" />
</div>
</form>
</c:if>
</div>
