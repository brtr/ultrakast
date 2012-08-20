//Set these arrays up to hold currently tagged user names and ids
var taggedNames = [];
var taggedIds = [];

$(document).ready(function() {
	
		
	$('.content a').attr('target', '_blank');
	//Translate links in post text to embedded content
	$('.content').embedly({
		//Place embedded content after post
		method: "after",
		maxWidth: 500,
		chars: 150,
		key: '6c398a44d6034de4b75ea047c32e83fe', //TODO: CHANGE THIS TO CLIENT'S API KEY
		
		//Override default success callback to insert target into anchors
		success: function(oembed, dict){
			var _a, elem = $(dict.node);
			if (! (oembed) ) { return null; }
			oembed.code = oembed.code.replace('<a href', '<a target="_blank" href');
			return elem.after(oembed.code);
		}
	});
	
	

	//AJAXify pagination links
	$('.pagination a').attr('data-remote', 'true');
	
	
	//Code to show and hide comments
	$(document).on("click", 'a.comment-link', function(e) {
		e.preventDefault();
		post_id = "div#comments-" + $(this).data('post-id');
		$(post_id).show();
		$(this).data("link-text", $(this).text());
		$(this).attr('class', 'hide-comment-link').text("Hide comments");
	});
	
	$(document).on("click", 'a.hide-comment-link', function(e) {
		e.preventDefault();
		post_id = "div#comments-" + $(this).data('post-id');
		$(post_id).hide();
		$(this).attr('class', 'comment-link').text($(this).data('link-text'));
	});
	
	//Code to show and hide likes
	
	$(document).on("click", 'a.likes-link', function(e) {
		e.preventDefault();
		post_id = "div#likes-for-" + $(this).data('post-id');
		$(post_id).show();
		$(this).data("link-text", $(this).text());
		$(this).attr('class', 'hide-likes-link').text("Hide likes");
	});
	
	$(document).on("click", 'a.hide-likes-link', function(e) {
		e.preventDefault();
		post_id = "div#likes-for-" + $(this).data('post-id');
		$(post_id).hide();
		$(this).attr('class', 'likes-link').text($(this).data('link-text'));
	});
	
	//Code to show and hide expanded category lists
	$(document).on("click", 'a.expand-link', function(e) {
		e.preventDefault();
		category_id = "ul#children-" + $(this).data('category-id');
		$(category_id).show();
		$(this).attr('class', 'contract-link').text('-');
	});
	
	$(document).on("click", 'a.contract-link', function(e) {
		e.preventDefault();
		category_id = "ul#children-" + $(this).data('category-id');
		$(category_id).hide();
		$(this).attr('class', 'expand-link').text('+');
	});
	
	$(document).on("click", 'a.parent-link', function(e) {		
		category_id = "ul#children-" + $(this).siblings('.expand-link').data('category-id');
		$(category_id).show();
		$(this).siblings('.expand-link').attr('class', 'contract-link').text('-');
	});
	
	//Run method to initialize tagging search functionality
	myLiveSearch();
	
	//Bind to live search result links
	$(document).on("click", 'a.live-search-result', function(e) {
		e.preventDefault();
		//Format text to be placed into post box
		result = '@' + $(this).text();
		//Add the tagged user to the arrays
		taggedNames.push(result);
		taggedIds.push($(this).attr('id'));
		//Replace the text in the post box with the selected user's full name
		replaceResult(result);
		//Reset the results box
		$("#user-search-results").html("");
		//Reset the live search for the next tag
		$('#post-box').unbind();
		myLiveSearch();
	});
	
	//When post is submitted, convert tagged users to their profile links
	$('.post-submit-button').on("click", function() {
		value = $('#post-box').val();
		for (i = 0; i <= taggedNames.length - 1; i++) {
			value = value.replace(taggedNames[i], '<a href="users/' + taggedIds[i] + '">' + taggedNames[i] + '</a>');
		}
		$('#post-box').val(value);
	});
});

	
function myLiveSearch() {
	//Init vars
	var search = false;
	var counter = 0;
	var searchString = '';
	var url = "/users/live_search?searchString=";
	//Regex
	var pattern = /@(\w*)(\s\w*)?/;
	//Bind to the post box's keypress
	$('#post-box').bind("keypress", function(e) {
		var c = String.fromCharCode(e.which);
		//If an @ sign has been received...
		if (search === true) {
			value = $('#post-box').val() + c;
			//Remove previously tagged names so they do not falsely trigger a regex match - we only want the tag the user is currently typing
			for (i = taggedNames.length - 1; i >= 0; i--) {
				value = value.replace(taggedNames[i], '');
			}
			matched = value.match(pattern);
			//Wait until the user has typed at least 3 characters to avoid hammering the server
			if (matched[0].length > 3) {
				//Get our result set from the controller/DB
				$.get(url + matched[0].substring(1, matched[0].length), function(html) {
					$("#user-search-results").html(html);	
				});
			} else {
				$("#user-search-results").html("");
			}
		}
		//Start searching after @ sign is detected
		if (c == '@') {
			search = true;
		}
	});
}

function replaceResult(result) {
	//Get the current text in the post box
	value = $('#post-box').val();
	editedVal = value;
	//Remove any previously tagged users
	for (i = 0; i < taggedNames.length - 1; i++) {
		editedVal = editedVal.replace(taggedNames[i], '');
	}
	var pattern = /@(\w*)(\s\w*)?/;
	matched = editedVal.match(pattern);
	$('#post-box').val(value.replace(matched[0], result + ' '));
	//Return focus to the text area
	$('#post-box').focus();
	//This is a workaround to get the cursor to the end of the text area
	var val = $('#post-box').val();
	$('#post-box').val('');
	$('#post-box').val(val);
}

