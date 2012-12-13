function isUndefined( f ) {
	return (typeof(f)=='undefined');
}
function isEmpty(f) {
	return f==null || isUndefined(f);
}
function isArray( f ) {
	return typeof(f)=="object" && !isUndefined(f.length);
}
function getObj(id) {
	var o;
	if (document.getElementById)
		o = document.getElementById(id);
	else if (document.all)
		o = document.all[id];
	if (isUndefined(o))
		o = null;
	return o;
}
function showObj(id,show) {
	if (isArray(id)) {
		var i;
		for(i=0; i<id.length; i++) {
			showObj(id[i],show);
		}
		return;
	}
	var o = getObj(id);
	if (o==null)
		return false;
	if (isUndefined(show))
		show = true;
	return o.style.display = (show?"":"none");
}
function addParam(url,key,val) {
	var idx = url.indexOf("?");
	val = escape(val);
	if (idx==-1) {
		url += "?";
	} else {
		url += "&";
	}
	return url+key+"="+val;
}
function parseParams(encoded) {
	var o = new Object();
	var params = encoded.split("&");
	for(var i=0; i<params.length; i++) {
		var p = params[i];
		var idx = p.indexOf("=");
		if (idx==-1) {
			o[p] = true;
		} else {
			var key = p.substring(0,idx);
			var val = p.substring(idx+1);
			vas = unescape(val);
			o[key] = val;
		}
	}
	return o;
}

function checkAll( field, check ) {
var i;
	if (isEmpty(field))
		return;
	if (isUndefined(field.length)) {
		field.checked = check;
	} else {
		for(i=0; i<field.length; i++)
			field[i].checked = check;
	}
}
function isChecked( field ) {
var i;
	if (isUndefined(field.length)) {
		return field.checked;
	} else {
		for(i=0; i<field.length; i++) {
			if (field[i].checked)
				return true;
		}
		return false;
	}
}
function isSelected( f, i ) {
	if (isUndefined(i))
		i = 0;
	try {
		return f.options[i].selected;
	} catch(e) {
	}
	return false;
}

function csSubnodeMap( csroot, nodeid, destmap ) {
	var i;
	var nodeids = csroot[nodeid];
	if (isUndefined(destmap))
		destmap = new Array();
	if (!isUndefined(nodeids)) {
		for(i=0; i<nodeids.length; i++) {
			destmap[nodeids[i]] = true;
			csSubnodeMap( csroot, nodeids[i], destmap );
		}
	}
	return destmap;
}
function csSubnodeSelect( field, csroot ) {
	var form = field.form;
	var fieldName = field.name;
	var fields = form[fieldName];
	if (isUndefined(fields.length))
		return;
	var subnodes = csSubnodeMap( csroot, field.value );
	var checked = field.checked;
	var i;
	for(i=0; i<fields.length; i++) {
		if (subnodes[fields[i].value]==true)
			fields[i].checked = checked;
	}
}

function popup( url, width, height, target, wparams ) {
	if (isUndefined(width))
		width = 350;
	if (isUndefined(height))
		height = 400;
	if (isUndefined(target))
		target = "_blank";
	if (isUndefined(wparams))
		wparams = "location=0,menubar=0,resizeable=1,scrollbars=1,status=0,titlebar=0";
	var w = window;
	if (!isEmpty(w.top))
		w = w.top;
	var left = (w.screen.width-width)/2;
	var top = w.screen.height*0.4-height/2;
	wparams = "height="+height+",width="+width
		+",left="+left+",top="+top
		+","+wparams;
	w.open( url, target, wparams );
}
function popupVersion( url ) {
	popup( url, 600, 200, "tmsversion" );
}
function popupHelp( url ) {
	popup( url, 640, 480, "tmshelp" );
}

function _onBodyUnload() {
	if (typeof(onBodyUnload)=="function") 
		onBodyUnload();
}
function _onBodyLoad() {
	if (typeof(onSetFocus)=="function") 
		onSetFocus();
	if (typeof(onBodyLoad)=="function") 
		onBodyLoad();
}
function fillSelect(sel,opts,fromIdx) {
	if (isUndefined(fromIdx))
		fromIdx = 0;
	while(fromIdx<sel.options.length) {
		sel.remove(fromIdx);
	}
	var count = opts.length;
	var i, o;
	for(i=0; i<count; i++) {
		if (typeof(opts[i])=="undefined" || opts[i]==null)
			continue;
		o = document.createElement("OPTION");
		o.value = opts[i].value;
		o.text = opts[i].text;
		if (typeof(document.all)!="undefined") // ie & opera
			sel.add(o);
		else // mozilla & firefox
			sel.appendChild(o);
	}
}

function clearForm( f ) {
	var i, e;
	for(i=0; i<f.elements.length; i++) {
		e = f.elements[i];
		switch(e.type) {
		case "select-one":
			if (e.options.length>0)
				e.selectedIndex = 0;
			break;
		case "text":
			e.value = "";
			break;
		}
	}
}

function addEvent( obj, eventname, newhandler ) {
	if (obj.addEventListener) {
		if (eventname.indexOf('on')==0)
			eventname = eventname.substring(2);
		obj.addEventListener( eventname, newhandler, true );
	} else if (obj[eventname]) {
		var oldhandler = obj[eventname];
		var f = function() { 
			oldhandler(); 
			newhandler(); 
			};
		//f.oldhandler = obj[eventname];
		//f.newhandler = handler;
		obj[eventname] = f;
	} else {
		obj[eventname] = newhandler;
	}
}
