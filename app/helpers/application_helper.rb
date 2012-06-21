module ApplicationHelper

  def full_title(page_title)
    base_title = "Prototype"
	  if page_title.empty?
	    base_title
	  else
	    "#{base_title} | #{page_title}"
  	end
  end
  
  def nested_categories(categories)
    categories.map do |category, sub_categories|
      content_tag(:div, render(category), :class => 'parent')
      sub_categories.map do |category, sub|
        content_tag(:div, render(category), :class => 'child')
      end
    end.join.html_safe

  end

end
