<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"%>
<c:set var="imageAlt" value="${not empty label?cleanLabel:cleanDescription}" />
<c:if test="${not empty file && not empty file.htmlTitle || not empty file.htmlDescription}">
	<c:if test="${not empty file.htmlTitle && not empty file.htmlDescription}">
		<c:set var="imageAlt" value="${file.htmlTitle} : ${file.htmlDescription}" />
	</c:if>
	<c:if test="${empty file.htmlTitle || empty file.htmlDescription}">
		<c:set var="imageAlt" value="${file.htmlTitle}${file.htmlDescription}" />
	</c:if>
</c:if>

<c:set var="imageWidthTag" value="" />
<c:if test="${not empty imageWidth && info.device.pdf}">
<c:set var="imageWidthTag" value='width="${imageWidth}" ' />
</c:if>
<c:set var="useLoadImage" value="${info.area != 'header' && info.area != 'banner' && param._loadImage}" />
<c:set var="imageStyle" value="" /><c:if test="${not empty componentWidth}"><c:set var="imageStyle" value=" style=\"width: ${componentWidth}\""/></c:if><div ${previewAttributes}><div id="test" class="${cssClass}">
<c:choose>
<c:when test="${link eq '#' || info.device.code == 'pdf'}">
<figure class="${type} img-${comp.id} ${svg?'svg':'not-svg'} ${not empty param.headerCaption?'balls-zone':''} ${manualCssClass}">
<div class="nolink">
<c:if test="${!info.device.pdf}"><picture class="img-fluid">
<source media="(max-width: 767px)" srcset="${smURL}" /></c:if>
<c:if test="${useLoadImage}">
<img id="img-${compid}" data-compid="${compid}" class="img-fluid${info.device.pdf?' return-size':''}" src="${loadURL}" data-src="${previewURL}" alt="${imageAlt}"${imageStyle} ${imageWidthTag} ${editPreview?"onload='editPreview.returnSize();'":""}/>
</c:if><c:if test="${!useLoadImage}">
<img id="img-${compid}" data-compid="${compid}" class="img-fluid${info.device.pdf?' return-size':''}" src="${previewURL}" srcset="${smURL} (max-width: 640px), ${lgURL} 2x" alt="${imageAlt}"${imageStyle} ${imageWidthTag} ${editPreview?"onload='editPreview.returnSize();'":""}/>
</c:if>
<c:if test="${!info.device.pdf}"></picture></c:if>
<c:if test="${not empty param.headerCaption && info.device.code != 'pdf'}">
	<div class="caption-out-wrapper">
		<div class="caption">
			<h1>${info.title}</h1>
		</div>
	</div>	
</c:if>
</div>
<c:if test="${empty param.nolabel && not empty label || not empty description && empty param.headerCaption}"><figcaption>${not empty label?label:description}</figcaption></c:if>
</figure>
</c:when>
<c:otherwise>
<c:if test="${not empty link}"><c:set var="url" value="${link}" /></c:if>
<c:set var="imgCaption" value=""
/><c:if test="${not empty cleanLabel}">
	<c:set var="imgCaption" value="data-caption=\"${cleanLabel}\" " />
</c:if>
<figure class="img-${comp.id} ${svg?'svg':'not-svg'} ${not empty param.headerCaption?'balls-zone':''}">
<c:set var="rel" value="${fn:startsWith(url,'http://')?'external':'shadowbox'}"
/><c:set var="rel" value="${fn:endsWith(url,'.pdf')?'pdf':rel}"
/><c:set var="relAttribute" value='rel="${rel}"'
/><c:set var="titleAttr" value=""
/><c:if test="${empty linkToImage}">
<c:set var="enlargeImage" value="${i18n.view['global.enlargeimage']}" />
<c:set var="titleAttr" value='title="${enlargeImage}"' />
</c:if>
<a <c:if test="${not empty file.imageSize}">data-width="${file.imageSize.width}" data-height="${file.imageSize.height}"</c:if> data-caption="${imageAlt}" id="lnk${file.id}" class="${type}" href="${url}" ${titleAttr} ${relAttribute} ${info.openExternalLinkAsPopup && (fn:startsWith(url,'http://') || fn:startsWith(url,'https://') || fn:startsWith(url,'//'))?' target="_blank"':''}>
	<c:if test="${useLoadImage}">
	<img id="img-${compid}" data-compid="${compid}" src="${loadURL}" data-src="${previewURL}" class="img-fluid${info.device.pdf?' return-size':''}" ${imageWidthTag} ${not empty imgCaption?imgCaption:''}alt="${imageAlt}"${imageStyle} ${imageWidth} ${editPreview?"onload='editPreview.returnSize();'":""}/>
	</c:if><c:if test="${!useLoadImage}">
	<img id="img-${compid}" data-compid="${compid}" src="${previewURL}" srcset="${smURL} (max-width: 640px), ${lgURL} 2x" class="img-fluid${info.device.pdf?' return-size':''}" ${imageWidthTag} ${not empty imgCaption?imgCaption:''}alt="${imageAlt}"${imageStyle} ${imageWidth} ${editPreview?"onload='editPreview.returnSize();'":""}/>
	</c:if>
	<c:if test="${not empty param.headerCaption}">
		<div class="caption carousel-caption container">
			<h1>${info.pageTitle}</h1>
			<c:set var="description" value="${info.pageDescription}" />			
			<c:if test="${not empty description}"><p>${description}</p></c:if>
		</div>
	</c:if>
</a>
<c:if test="${empty param.nolabel}">
<c:set var="copyrightHTML" value="" />
<c:if test="${not empty copyright}"><c:set var="copyrightHTML" value='<span class="copyright">${copyright}</span>' /></c:if>
<c:if test="${not empty copyright || not empty label || not empty description}"><figcaption>${not empty label?label:description}${copyrightHTML}</figcaption></c:if>
</c:if>
</figure>
</c:otherwise>
</c:choose>
</div></div>
<c:if test="${empty param.noswipe && !info.device.pdf}">
<script>document.addEventListener("DOMContentLoaded", function(event) {
	initPhotoSwipeFromDOM('.img-${comp.id} a');	
});</script></c:if>