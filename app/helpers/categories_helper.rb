module CategoriesHelper
  def categories_to_checkboxes(categories)
	  categories.map do |category, sub_categories|
	    sub_code = content_tag(:ul,
	    sub_categories.map do |k, v|
	      content_tag(:li, render('categories/category', :category => k), :class => "child #{category.name}") + "\n"
	    end.join.html_safe).html_safe
	    content_tag(:ul, (content_tag(:li, render('categories/category', :category => category), :class => "parent #{category.name}") + "\n" + sub_code))  
    end.join.html_safe
  end
  
  def list_categories(categories)
	categories.map do |category, sub_categories|
	  sub_code = content_tag(:ul, 
	    sub_categories.map do |k, v|
	      content_tag(:li, k.name, :class => "child #{category.name}") + "\n"
	    end.join.html_safe).html_safe
	    content_tag(:ul, (content_tag(:li, category.name, :class => "parent #{category.name}") + "\n" + sub_code))
    end.join.html_safe
  end
  
  
end