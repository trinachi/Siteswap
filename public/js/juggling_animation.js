function findPattern() {
	$('.pattern').click(function() {
		$(this).addClass("red");
		var propNumber = $('.props').text();
		var props = parseInt(propNumber);
		var patterns = $(this).text().split('');
		var pattern =  $.each(patterns, function(k, v) {
			parseInt(v);
		});
		console.log(props);
		console.log(pattern);
		addListItems(pattern, props);
	});
};

function addListItems(pattern, props) {
	$("#canvas").html("");

for ( var i = 1; i <= props; i++ ) {
	var listItem = $('<li>').attr('class', 't' + i);
	if (i%2 === 0) listItem.addClass('r' + pattern[ i-1]); 
	if (i%2 !== 0) listItem.addClass('l' + pattern[ i-1]);
	if (pattern.length < i && i%2 === 0) listItem.addClass('r' + pattern[ i-(pattern.length + 1)]);
	if (pattern.length < i && i%2 !== 0) listItem.addClass('l' + pattern[ i-(pattern.length + 1)]);
	if (pattern.length*2 < i && i%2 === 0) listItem.addClass('r' + pattern[ i-(pattern.length*2 + 1)]);
	if (pattern.length*2 < i && i%2 !== 0) listItem.addClass('l' + pattern[ i-(pattern.length*2 + 1)]);
    $('#canvas').append(listItem);
  }
	$('#canvas > li').append('<div class="ball"></div>');
};

function changeClass(pattern, props) {
	for ( var i = props + 1; i <= props*2; i++ ) {
		$('#canvas > li').delay((i-props)*1000).removeClass('t' + (i - props)).addClass('t' + i);
	}
};

$(document).ready(function() {
	findPattern();
});

