class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @post = current_user.posts.build
      session[:category_filter] = "all"
      session[:feed_status] = "private"
      session[:filter_title] = ""
	    session[:selected_category] = "all"
  	  session[:sort_order] = "recent"
	    session[:user] = current_user.id
	  @feed_items = User.find(session[:user]).feed(session[:feed_status], session[:category_filter], session[:sort_order]).paginate(page: params[:page], per_page: 10)
    end
  end
  
  def switch_feed
   
    #set user
	unless params[:user].nil?
		session[:user] = params[:user]
	end
	#set sort
	unless params[:sort_order].nil?
	  session[:sort_order] = params[:sort_order]
	end
	
	unless params[:feed_status].nil?
	  session[:feed_status] = params[:feed_status]
	end
	
	unless params[:selected_category].nil?
	  session[:selected_category] = params[:selected_category]
	end
	
	  
    #Set page
    if params[:page].nil?
      session[:page] = 1
    else
      session[:page] = params[:page]
    end
    
    update_dropdown
    
	@filter_title = filter_title(session[:filter_title])  
	@feed_items = User.find(session[:user]).feed(session[:feed_status], session[:category_filter], session[:sort_order]).paginate(page: session[:page], per_page: 10)
	  
	if session[:category_filter] != "all"

	  cat = Category.find(session[:selected_category])
	    
	  status = ReadStatus.where("user_id = ? AND category_id = ?", current_user.id, cat.id).first
	end
	
	
	if status.nil?
	  status = ReadStatus.create(:user_id => current_user, :category_id => cat, :last_read_time => Time.now)
	else
	  status.last_read_time = Time.now
	  status.save
	end

	  @post = current_user.posts.build(params[:post])
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
	    @dropdown_parents = current_user.categories.roots.order('id ASC')
    	@dropdown_children = current_user.category_ids


      else
		category = Category.find(session[:selected_category])
        
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
