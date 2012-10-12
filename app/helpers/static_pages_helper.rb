module StaticPagesHelper

  def filter_title(base_title)
    unless base_title.nil?
      if base_title == ""
        base_title
      else
        "(filtered by " + base_title + ")"
      end
    end
  end
  
  def get_friends
    if current_user.friends.count == 0
	    return
	  end
    category = Category.includes(:users).find(session[:selected_category])
    @friends = category.users.where("users.id IN (?)", current_user.friends)
  end
end
