class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @post = current_user.posts.build
      session[:category_filter] = Category.ids
	    session[:feed_status] = "private"
	    session[:filter_title] = ""
	    @feed_items = current_user.feed(session[:feed_status], session[:category_filter])
    end
  end
  
  def switch_feed	
	  unless params[:feed_status].nil?
	    session[:feed_status] = params[:feed_status]
	  end
	
	  unless params[:category_filter].nil?
	    if params[:category_filter] == ""
		    session[:category_filter] = Category.ids
		  else
	      session[:category_filter] = params[:category_filter]
	    end
	  end
	  
	  unless params[:filter_title].nil?
	    if params[:filter_title] == ""
	      session[:filter_title] = ""
	    else
	      session[:filter_title] = "(filtered by " + params[:filter_title] + ")"
	    end
	  end
	  @filter_title = session[:filter_title]
	  @feed_items = current_user.feed(session[:feed_status], session[:category_filter])
	  unless @filter_title == ""
	    @feed_items.each do |item|
		  item.read_by!(current_user)
		end
	  end
	      respond_to do |format|
	    format.js { render :layout => false }
	  end 
  end
end
