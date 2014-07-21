//Handles category link and checkbox behavior on user's new and edit profile pages
$(document).ready(function() {
  $('.users img').css({
	    height: 100,
	    width: 100
	});
  //Checkbox behavior
  $('input[type="checkbox"]').change(function() {
    if ($(this).is(':checked')) {
      if ($(this).parent().hasClass('parent'))
      {
        // $(this).parent().siblings('ul').children().children('input:checkbox').attr('checked', true);
        $('.contract-link').attr('class', 'expand-link').text('+');
        $('.children-list').hide();
        category_id = "ul#children-" + $(this).siblings('a.category-select-link').data('category-id');
        $(category_id).show();
        $(this).siblings('.expand-link').attr('class', 'contract-link').text('-');
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
  
  //Category link behavior
  $(document).on("click", 'a.category-select-link', function(e) {
    e.preventDefault();
    $('.contract-link').attr('class', 'expand-link').text('+');
    $('.children-list').hide();
    category_id = "ul#children-" + $(this).data('category-id');
    $(category_id).show();
    $(this).siblings('.expand-link').attr('class', 'contract-link').text('-');  
  });
});