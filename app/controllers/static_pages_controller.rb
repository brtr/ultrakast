class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @post = current_user.posts.build
      #       if session[:category_filter].nil?
      #         session[:category_filter] = Category.ids
      # end
	    
      # if session[:feed_status].nil? 
      #   session[:feed_status] = "private"
      # end
	    
	    if session[:filter_title].nil?
	      session[:filter_title] = ""
	    end
	    
	    @feed_items = current_user.feed(session[:feed_status], session[:category_filter]).paginate(page: params[:page], per_page: 10)
    end
  end
  
  def switch_feed	
	  unless params[:feed_status].nil?
	    session[:feed_status] = params[:feed_status]
	  end
	  
    if params[:page].nil?
          session[:page] = 1
        else
          session[:page] = params[:page]
        end
    
	
	  unless params[:category_filter].nil?
	    if params[:category_filter] == ""
		    session[:category_filter] = Category.ids
		  else
	      session[:category_filter] = params[:category_filter]
	    end
	  end
    
	  @filter_title = filter_title(params[:filter_title])
	  @feed_items = current_user.feed(session[:feed_status], session[:category_filter]).paginate(page: session[:page], per_page: 10)
	  unless @filter_title == ""
	    @feed_items.each do |item|
		  item.read_by!(current_user)
		end
	  end
	      respond_to do |format|
	        format.html
	    format.js
	  end 
  end
end
