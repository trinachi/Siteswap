function findPattern() {
	// var pattern = [4, 4, 1];
	$('.pattern').click(function() {
		$(this).addClass("red");
		var patterns = $(this).text().split('');
		var pattern =  $.each(patterns, function(k, v) {
			parseInt(v);
		});
		console.log(pattern);
		addListItems(pattern);
	});
};

function addListItems(pattern) {
	$("#canvas").html("");
for ( var i = 1; i <= pattern.length; i++ ) {
	var listItem = $('<li>').attr('class', 't' + i);
	if (i%2 === 0) listItem.addClass('r' + pattern[ i-1]); 
	if (i%2 !== 0) listItem.addClass('l' + pattern[ i-1]);
    $('#canvas').append(listItem);
  }
	$('#canvas > li').append('<div class="ball"></div>');
};

$(document).ready(function() {
	findPattern();
});

console.log(findPattern());

