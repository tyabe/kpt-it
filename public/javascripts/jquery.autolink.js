// via. https://gist.github.com/thealscott/2829002
jQuery.fn.highlight = function (text, o) {
	return this.each( function(){
		var replace = o || '<span class="highlight">$1</span>';
		$(this).html( $(this).html().replace( new RegExp('('+text+'(?![\\w\\s?&.\\/;#~%"=-]*>))', "ig"), replace) );
	});
}

jQuery.fn.autolink = function (target) {
    if (target == null) target = '_parent';
	return this.each( function(){
		var re = /((http|https|ftp):\/\/[\w?=&.\/-;#~%-]+(?![\w\s?&.\/;#~%"=-]*>))/g;
		$(this).html( $(this).html().replace(re, '<a href="$1" target="'+ target +'">$1</a> ') );
	});
}

jQuery.fn.mailto = function () {
	return this.each( function() {
		var re = /(([a-z0-9*._+]){1,}\@(([a-z0-9]+[-]?){1,}[a-z0-9]+\.){1,}([a-z]{2,4}|museum)(?![\w\s?&.\/;#~%"=-]*>))/g;
		$(this).html( $(this).html().replace( re, '<a href="mailto:$1">$1</a>' ) );
	});
}

jQuery.fn.hashtaglink = function (target) {
    if (target == null) target = '_parent';
	return this.each( function() {
        var re = /#([^\s]+)/g;
		$(this).html( $(this).html().replace( re, '<a href="https://twitter.com/search?q=%23$1" target="'+ target +'">#$1</a>' ) );
	});
}
