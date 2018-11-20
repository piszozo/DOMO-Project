var langs = ['en', 'it', 'fr'];
var langCode = 'en';			//Write the default Value from langs into it
var langJS = null;

function setLanguage(lang) {
	langCode = lang;
if ($.inArray( langCode, langs ) >= 0){
	$.getJSON('lang/'+langCode+'.json', translate);
}else{
	$.getJSON('lang/en.json', translate);
}	
}
var translate = function (jsdata)
{	
	$("[tkey]").each (function (index)
	{
		var strTr = jsdata [$(this).attr ('tkey')];
	    $(this).html (strTr);
	});
}
if(langCode == 'en'){
	$.getJSON('lang/en.json', translate);		
}

