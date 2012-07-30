$(document).ready(function() {
	$('.posts').embedly({
		maxWidth: 150,
		key: '6c398a44d6034de4b75ea047c32e83fe'});
		
	$('.pagination a').attr('data-remote', 'true');
	
	
	$('a.comment-link').live("click", function(e) {
		e.preventDefault();
		post_id = "div#comments-" + $(this).attr('id');
		$(post_id).show();
		$(this).data("link-text", $(this).text());
		$(this).attr('class', 'hide-comment-link').text("Hide comments");
		
	});
	
	$('a.hide-comment-link').live("click", function(e) {
		e.preventDefault();
		post_id = "div#comments-" + $(this).attr('id');
		$(post_id).hide();
		$(this).attr('class', 'comment-link').text($(this).data('link-text'));
	});
	
});