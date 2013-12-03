function switchDisplay(id, img, imgpath)
{
    var element = document.getElementById(id);
    if (element.style.display == 'none') {
        element.style.display = 'block';
        if (img !== null) {
	        img.src=imgpath+'minus.png';
        }
    } else {
        element.style.display = 'none';
        if (img !== null) {
	        img.src=imgpath+'plus.png';
	    }
    }
}

function closeAllDirFile() {
	var myObjColl = getElementsByClassName('hiddenblock');
	for (var i = 0, j = myObjColl.length; i < j; i++) {
		myObjColl[i].style.display = 'none';
	}
}

function newDir(id) {
	var	element = document.getElementById('ndir'+id);
	var akt = element.style.display;
	closeAllDirFile();
	if(akt != 'block') {
		element.style.display = 'block';
		document.getElementById('whichOne').value = id;
	}
}

function newFile(id) {
	var	element = document.getElementById('nfile'+id);
	var akt = element.style.display;
	closeAllDirFile();
	if (akt != 'block') {
		element.style.display = 'block';
		document.getElementById('whichOne').value = id;
	}
}

function showVersion(id) {
	var myObjColl = getElementsByClassName('hiddenblock');
	j = myObjColl.length;
	for (var i = 0; i < j; i++) {
		myObjColl[i].style.display = 'none';
	}
	document.getElementById(id).style.display = 'block';
}

function getElementsByClassName(strClass, strTag, objContElm) {
  strTag = strTag || "*";
  objContElm = objContElm || document;
  var objColl = objContElm.getElementsByTagName(strTag);
  if (!objColl.length &&  strTag == "*" &&  objContElm.all) objColl = objContElm.all;
  var arr = new Array();
  var delim = strClass.indexOf('|') != -1  ? '|' : ' ';
  var arrClass = strClass.split(delim);
  for (var i = 0, j = objColl.length; i < j; i++) {
    var arrObjClass = objColl[i].className.split(' ');
    if (delim == ' ' && arrClass.length > arrObjClass.length) continue;
    var c = 0;
    comparisonLoop:
    for (var k = 0, l = arrObjClass.length; k < l; k++) {
      for (var m = 0, n = arrClass.length; m < n; m++) {
        if (arrClass[m] == arrObjClass[k]) c++;
        if (( delim == '|' && c == 1) || (delim == ' ' && c == arrClass.length)) {
          arr.push(objColl[i]);
          break comparisonLoop;
        }
      }
    }
  }
  return arr;
}

// To cover IE 5.0's lack of the push method
Array.prototype.push = function(value) {
  this[this.length] = value;
}

function showpopup(name) {
element = document.getElementById(name);
element.style.display = 'block';
}
function hidepopup(name) {
element = document.getElementById(name);
element.style.display = 'none';
}
