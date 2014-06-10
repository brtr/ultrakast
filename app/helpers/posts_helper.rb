module PostsHelper
  def display_category(category)
	  if category.ancestry.nil?
	    category.name
	  else
	    category.parent.name + " / " + category.name
	  end
  end
end