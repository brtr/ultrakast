module PostsHelper

  def display_category(feed_item)
    cat = Category.find(feed_item.category_id)
	if cat.ancestry.nil?
	  cat.name
	else
	  cat.parent.name + " / " + cat.name
	end
  end
end