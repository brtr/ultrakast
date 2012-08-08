


$(document).ready(function() {
	$('.posts').embedly({
		maxWidth: 500,
		key: '6c398a44d6034de4b75ea047c32e83fe'});
		
	$('.pagination a').attr('data-remote', 'true');
	
	
	$('a.comment-link').live("click", function(e) {
		e.preventDefault();
		post_id = "div#comments-" + $(this).data('post-id');
		$(post_id).show();
		$(this).data("link-text", $(this).text());
		$(this).attr('class', 'hide-comment-link').text("Hide comments");
		
	});
	
	$('a.hide-comment-link').live("click", function(e) {
		e.preventDefault();
		post_id = "div#comments-" + $(this).data('post-id');
		$(post_id).hide();
		$(this).attr('class', 'comment-link').text($(this).data('link-text'));
	});
	
	
	$('a.expand-link').live("click", function(e) {
		e.preventDefault();
		category_id = "ul#children-" + $(this).data('category-id');
		$(category_id).show();
		$(this).attr('class', 'contract-link').text('-');
	});
	
	$('a.contract-link').live("click", function(e) {
		e.preventDefault();
		category_id = "ul#children-" + $(this).data('category-id');
		$(category_id).hide();
		$(this).attr('class', 'expand-link').text('+');
	});
	
	myLiveSearch();
});

	
function myLiveSearch() {
	var counter = 0;
	var searchString = '';
	$('#post-box').bind("keypress", function(e) {
		var c = String.fromCharCode(e.which);
		if (c == '@') {
			alert(counter);
			counter++;
			searchString = searchString + c;
		}
	});
	alert("outside");
	if (counter == 3) {
		alert(searchString);
		('#post-box').unbind();
	}
}



