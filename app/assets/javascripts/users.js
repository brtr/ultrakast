$(document).ready(function() {
	$('input[type="checkbox"]').change(function() {
		if ($(this).is(':checked')) {
			if ($(this).parent().hasClass('parent'))
			{
				$(this).parent().siblings('ul').children().children('input:checkbox').attr('checked', true);
			}
			else
			{
			    $(this).parent().parent().siblings('li').children('input:checkbox').attr('checked', true);
			}
		}
		else
		{
			if ($(this).parent().hasClass('parent'))
				{
					$(this).parent().siblings('ul').children().children('input:checkbox').attr('checked', false);
				}
		}
	});
});

