function findPattern() {
	$('.pattern').click(function() {
		$(this).addClass("red");
		var propNumber = $('.props').text();
		var props = parseInt(propNumber);
		var patterns = $(this).text().split('');
		var pattern =  $.each(patterns, function(k, v) {
			parseInt(v);
		});
		console.log(pattern);
		addListItems(pattern, props);
	});
};

function thisQueue(i, pattern, props) {
	if (i > pattern.length) {
		var j = i-pattern.length;
	}else{
		var j = i;
	}
	var throwIndex = parseFloat(pattern[ j-1]);
	$(this).delay(throwIndex*1000).queue(function(next) {
		if (throwIndex % 2 !== 0 && j === 1) {
			$('.t' + j).removeClass('l' + throwIndex).addClass('r' + ((throwIndex-1)-((throwIndex+(j-1))-pattern.length)));
			console.log(j);
			next();
		}
		
		if (throwIndex % 2 !== 0 && j === 2) {
			$('.t' + j).removeClass('r' + throwIndex).addClass('l' + ((throwIndex-1)-((throwIndex+(j-1))-pattern.length)));
			console.log(j);
			next();
		}
		
		if (throwIndex % 2 === 0 && j === 1) {
			$('.t' + j).removeClass('l' + throwIndex).addClass('l' + ((throwIndex-1)-((throwIndex+(j-1))-pattern.length)));
			console.log(j);
			next();
		}
		
		if (throwIndex % 2 === 0 && j === 2) {
			$('.t' + j).removeClass('r' + throwIndex).addClass('r' + ((throwIndex-1)-((throwIndex+(j-1))-pattern.length)));
			console.log(j);
			next();
		}
	});
};

function addListItems(pattern, props) {
	$("#canvas").html("");

	for ( var i = 1; i <= props; i++ ) {
		var listItem = $('<li>').attr('class', 't' + i);
		if (i > pattern.length) {
			var j = i-pattern.length;
		}else{
			var j = i;
		}
		
		if (j%2 === 0) {
			listItem.addClass('r' + pattern[ j-1]);
			thisQueue(i, pattern, props);
		}
		
		if (j%2 !== 0) {
		 	listItem.addClass('l' + pattern[ j-1]);
			thisQueue(i, pattern, props);
		}
		
	    $('#canvas').append(listItem);
	}
	$('#canvas > li').append('<div class="ball"></div>');
};

$(document).ready(function() {
	findPattern();
});

