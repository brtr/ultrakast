class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @post = current_user.posts.build
      session[:category_filter] = "all"
      session[:feed_status] = "private"
      session[:filter_title] = ""
  	  @feed_items = current_user.feed(session[:feed_status], session[:category_filter]).paginate(page: params[:page], per_page: 10)
    end
  end
  
  def switch_feed	
    
	  unless params[:feed_status].nil?
	    session[:feed_status] = params[:feed_status]
	  end
	  
    #Set page
    if params[:page].nil?
      session[:page] = 1
    else
      session[:page] = params[:page]
    end
    
    update_dropdown
    
	  @filter_title = filter_title(session[:filter_title])  
	  @feed_items = current_user.feed(session[:feed_status], session[:category_filter]).paginate(page: session[:page], per_page: 10)
	  
	  
	  # NEED TO REFACTOR THE UNREAD COUNT FUNCTIONALITY
	  #unless @filter_title == ""
	  #  @feed_items.each do |item|
	  #  item.read_by!(current_user)
	  #end
	  #end
	  respond_to do |format|
	    format.html
	    format.js
	  end
	end
	  
	def update_dropdown
	  #Set the category dropdown options based on filter settings
	    
	  unless params[:category_filter].nil?
	    session[:category_filter] = params[:category_filter]
	  end
	  
	  unless params[:filter_title].nil?
	    session[:filter_title] = params[:filter_title]
	  end
	  
	  if session[:category_filter] == "all"
	    @dropdown_parents = current_user.categories.roots.order('name ASC')
    	@dropdown_children = current_user.category_ids
    else
      category = Category.find_by_name(session[:filter_title])

  	  if category.ancestry.nil? #Filtered on parent category - return all children
  	    @dropdown_parents = [category] #Needs to be passed as an array so grouped_collection_select can use map on it
  	    @dropdown_children = session[:category_filter]
  	  else
  	    @dropdown_parents = [category.parent]
  	    @dropdown_children = category.id
      end
    end
	

	
  end
end
