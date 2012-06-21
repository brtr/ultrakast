module CategoriesHelper
  def categories_to_checkboxes(categories)
	categories.map do |category, sub_categories|
	  content_tag(:div, render(category), :class => "parent parent-#{category.name}") +
	  sub_categories.map do |k, v|
	    content_tag(:div, render(k), :class => "child child-#{category.name}")
	  end.join.html_safe
    end.join.html_safe
  end
  
  def list_categories(categories)
	categories.map do |category, sub_categories|
	  content_tag(:h2, category.name, :class => "parent-list parent-#{category.name}") +
	  sub_categories.map do |k, v|
	    content_tag(:h3, k.name, :class => "child-list parent-#{category.name}")
	  end.join.html_safe
    end.join.html_safe
  end
  
  
end