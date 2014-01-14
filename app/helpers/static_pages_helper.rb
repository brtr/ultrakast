module StaticPagesHelper

  # Filter title helper
  def filter_title(base_title)
    unless base_title.nil?
      if base_title == ""
        "Home"
      elsif base_title == "show_page"
        ""
      else
        base_title
      end
    end
  end
  
  # Return list of user's friends for a specified category
  def get_friends
    if current_user.friends.count == 0
	    return
	  end
	  if session[:selected_category] == "all"
	    @friends = current_user.friends
	  else
      category = Category.includes(:users).find(session[:selected_category])
      @friends = category.users.where("users.id IN (?)", current_user.friends)
    end
  end
  
  def get_everyone_in_category
    if !current_user
      return
    elsif session[:selected_category] == "all"
      @friends = current_user.friends
    else
      category = Category.includes(:users).find(session[:selected_category])
      @friends = category.users.where("users.id != (?)", current_user)       
    end
  end
  
  def get_everyone
    if current_user
      @friends = User.where("users.id != (?)", current_user)
    end  
  end
  
end
