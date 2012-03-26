function findPattern() {
	$('.pattern').click(function() {
		$(this).addClass("red");
		var propNumber = $('.props').text();
		var props = parseInt(propNumber);
		var patterns = $(this).text().split('');
		var pattern =  $.each(patterns, function(k, v) {
			parseInt(v);
		});
		addListItems(pattern, props);
	});
};

function thisQueue(i, pattern, props) {
	var j = i;
	$(this).delay(pattern[ j-1]*900).queue(function(next) {
		$('.t' + j).removeClass('l' + pattern[ j-1]).addClass('r' + pattern[ j]);
		// Figure out how to add this correct number from array for class -- timing issue
		next();
	});
};

function addListItems(pattern, props) {
	$("#canvas").html("");

	for ( var i = 1; i <= props; i++ ) {
		var listItem = $('<li>').attr('class', 't' + i);
		
		if (i%2 === 0) {
			listItem.addClass('r' + pattern[ i-1]);
		}
		
		if (i%2 !== 0) {
		 	listItem.addClass('l' + pattern[ i-1]);
			thisQueue(i, pattern, props);
		}
	
		if (pattern.length < i && i%2 === 0) listItem.addClass('r' + pattern[ i-(pattern.length + 1)]);
		if (pattern.length < i && i%2 !== 0) listItem.addClass('l' + pattern[ i-(pattern.length + 1)]);
		if (pattern.length*2 < i && i%2 === 0) listItem.addClass('r' + pattern[ i-(pattern.length*2 + 1)]);
		if (pattern.length*2 < i && i%2 !== 0) listItem.addClass('l' + pattern[ i-(pattern.length*2 + 1)]);
	    $('#canvas').append(listItem);
	}
	$('#canvas > li').append('<div class="ball"></div>');
};

$(document).ready(function() {
	findPattern();
});

