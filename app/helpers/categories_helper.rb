module CategoriesHelper
  def categories_to_checkboxes(categories)
	categories.map do |category, sub_categories|
	  content_tag(:div, render(category), :class => 'parent') +
	  sub_categories.map do |k, v|
	    content_tag(:div, render(k), :class => 'child')
	  end.join.html_safe
    end.join.html_safe
  end
end