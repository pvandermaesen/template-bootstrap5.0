 // javlo.js v3.0 - no jquery

var DEBUG_AJAX_SEARCH = false;

document.addEventListener("DOMContentLoaded", function (event) {
	staticSearch();
});

/**************/
/*** SEARCH ***/
/**************/

function staticSearch() {
	var dataItem = document.getElementById('staticSearchData');
	var buttonItem = document.getElementById('staticSearchButton');
	var resultItem = document.getElementById('staticSearchResult');
	if (dataItem != null && buttonItem != null && resultItem != null) {
		var data = [];
		var _searchDataReady = false;
		buttonItem.onfocus = function () {
			var opts = {
				method: 'GET',
				headers: {}
			};
			fetch(dataItem.getAttribute('href'), opts).then(function (response) {
				return response.json();
			})
				.then(function (json) {
					data = json;
					_searchDataReady = true;
					if (DEBUG_AJAX_SEARCH) {
						console.log("search map json : ", json);
					}
				});
		};
		searchUpdate = function () {
			if (_searchDataReady) {
				resultItem.innerHTML = '';
				if (this.value.length > 1) {
					result = search(this.value, data, 9);
					if (result.length == 0) {
						resultItem.classList.remove("result");
						resultItem.classList.add("no-result");
					} else {
						resultItem.classList.remove("no-result");
						resultItem.classList.add("result");
						result.forEach(function (item) {
							if (item.description != null) {
								resultItem.innerHTML += '<a class="search-item" href="' + item.url + '"><span class="search-title" >' + item.title + '</span><p>' + item.description + '</p></a>';
							} else {
								resultItem.innerHTML += '<a class="search-item" href="' + item.url + '"><span class="search-title">' + item.title + '</span></a>';
							}
						});
					}
				} else {
					resultItem.classList.remove("result");
					resultItem.classList.add("no-result");
				}
			}
		};
		buttonItem.onkeyup = searchUpdate;
		buttonItem.onpaste = searchUpdate;
	} else {
		if (DEBUG_AJAX_SEARCH) {
			console.log("ajax search form not found. [dataItem=" + dataItem + ", buttonItem=" + buttonItem + ", resultItem=" + resultItem + "]");
		}
	}
}

function search(text, data, maxResult) {
	text = text.toLowerCase();
	var result = [];
	data.pages.forEach(function (item) {
		weight = 0;
		if (item.title != null && item.title.toLowerCase().indexOf(text) >= 0) {
			weight = 3;
		}
		if (item.description != null && item.description.toLowerCase().indexOf(text) >= 0) {
			weight = weight + 2;
		}
		if (item.content != null && item.content.toLowerCase().indexOf(text) >= 0) {
			weight = weight + 1;
		}
		if (weight > 0) {
			weight = weight + item.weight;
			page = { url: item.url, title: item.title, description: item.description, weight: weight };
			result.push(page);
		}
	});

	if (maxResult > result.length) {
		return result;
	}

	var bestResult = [];
	while (bestResult.length < maxResult) {
		bestWeight = -1;
		bestItem = null;
		result.forEach(function (item) {
			if (item.weight > bestWeight && bestResult.indexOf(item) == -1) {
				bestWeight = item.weight;
				bestItem = item;
			}
		});
		page = { url: bestItem.url, title: bestItem.title, description: bestItem.description, weight: bestItem.weight };
		bestItem.weight = 0;
		bestResult.push(page);
	}
	return bestResult;
}

function ajaxSubmitForm(form, successFunction, json) {
	const params = new URLSearchParams();
	for (const pair of new FormData(form)) {
		params.append(pair[0], pair[1]);
	}
	if (json) {
		fetch(form.action, { body: params, method: 'post', 'Content-Type': 'text/plain; charset=UTF-8' })
			.then(response => {
				return response.json()
			})
			.then(data => {
				try {
					successFunction(data);
				} catch (error) {
					successFunction();
				}
			});
	} else {
		fetch(form.action, { body: params, method: 'post', 'Content-Type': 'text/plain; charset=UTF-8' })
			.then(response => {
				successFunction(response.text());
			})
	}
}

function executeFunctionByName(functionName, context, args) {
	var args = Array.prototype.slice.call(arguments, 2);
	var namespaces = functionName.split(".");
	var func = namespaces.pop();
	for (var i = 0; i < namespaces.length; i++) {
		context = context[namespaces[i]];
	}
	return context[func].apply(context, args);
}

/***********************/
/*** UTILS FONCTIONS ***/
/***********************/

reloadPage = function () {
	var doc = document.documentElement, body = document.body;
	var topScroll = (doc && doc.scrollTop || body && body.scrollTop || 0);
	var currentURL = window.location.href;
	if (currentURL.indexOf("_scrollTo") >= 1) {
		currentURL = currentURL.substring(0,
			currentURL.indexOf("_scrollTo") - 1);
	}
	if (currentURL.indexOf("?") < 0) {
		currentURL = currentURL + "?" + "_scrollTo=" + topScroll;
	} else {
		currentURL = currentURL + "&" + "_scrollTo=" + topScroll;
	}
	window.location.href = currentURL;
}

function elementInViewport(el) {
	var top = el.offsetTop;
	var left = el.offsetLeft;
	var width = el.offsetWidth;
	var height = el.offsetHeight;

	while (el.offsetParent) {
		el = el.offsetParent;
		top += el.offsetTop;
		left += el.offsetLeft;
	}

	return (
		top < (window.pageYOffset + window.innerHeight) &&
		left < (window.pageXOffset + window.innerWidth) &&
		(top + height) > window.pageYOffset &&
		(left + width) > window.pageXOffset
	);
}

function askFullscreen() {
	var elem = document.getElementsByTagName("body")[0];
	if (elem.requestFullscreen) {
		elem.requestFullscreen();
	} else if (elem.msRequestFullscreen) {
		elem.msRequestFullscreen();
	} else if (elem.mozRequestFullScreen) {
		elem.mozRequestFullScreen();
	} else if (elem.webkitRequestFullscreen) {
		elem.webkitRequestFullscreen();
	}
}

function cancelFullScreen() {
	if (document.cancelFullScreen) {
		document.cancelFullScreen();
	} else if (document.mozCancelFullScreen) {
		document.mozCancelFullScreen();
	} else if (document.webkitCancelFullScreen) {
		document.webkitCancelFullScreen();
	} else if (document.msCancelFullScreen) {
		document.msCancelFullScreen();
	}
}

function addParam(url, params) {
	var isQuestionMarkPresent = url && url.indexOf('?') !== -1,
		separator = '';
	if (params) {
		separator = isQuestionMarkPresent ? '&' : '?';
		url += separator + params;
	}
	return url;
}

function findGetParameter(parameterName, defaultValue) {
	var result = null,
		tmp = [];
	location.search
		.substr(1)
		.split("&")
		.forEach(function (item) {
			tmp = item.split("=");
			if (tmp[0] === parameterName) {
				result = (tmp[1] + '').replace(/\+/g, '%20');
				result = decodeURIComponent(result);
			}
		});
	if (result == null) {
		return defaultValue;
	} else {
		return result;
	}
}

function getArea(url, area) {
	url = addParam(url, "area-only="+area);
	fetch(dataItem.getAttribute('href'), opts).then(function (response) {
		return response;
	});
}

function removeParam(sourceURL, key) {
	var rtn = sourceURL.split("?")[0],
		param,
		params_arr = [],
		queryString = (sourceURL.indexOf("?") !== -1) ? sourceURL.split("?")[1] : "";
	if (queryString !== "") {
		params_arr = queryString.split("&");
		for (var i = params_arr.length - 1; i >= 0; i -= 1) {
			param = params_arr[i].split("=")[0];
			if (param === key) {
				params_arr.splice(i, 1);
			}
		}
		rtn = rtn + "?" + params_arr.join("&");
	}
	return rtn;
}

function wrap(el, wrapper) {
	el.parentNode.insertBefore(wrapper, el);
	wrapper.appendChild(el);
}

function getBody(content) {
	var x = content.indexOf("<body");
	x = content.indexOf(">", x);
	var y = content.lastIndexOf("</body>");
	return content.slice(x + 1, y);
}

function setCookie(cname, cvalue, exdays) {
	var d = new Date();
	d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
	var expires = "expires=" + d.toUTCString();
	document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/;SameSite=Strict";
}

function getCookie(cname) {
	var name = cname + "=";
	var decodedCookie = decodeURIComponent(document.cookie);
	var ca = decodedCookie.split(';');
	for (var i = 0; i < ca.length; i++) {
		var c = ca[i];
		while (c.charAt(0) == ' ') {
			c = c.substring(1);
		}
		if (c.indexOf(name) == 0) {
			return c.substring(name.length, c.length);
		}
	}
	return "";
}