class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @post = current_user.posts.build
      session[:category_filter] = current_user.category_ids
	  session[:feed_status] = "private"
	  @feed_items = current_user.feed(session[:feed_status], session[:category_filter])
    end
  end
  
  def switch_feed
    	
	unless params[:feed_status].nil?
	  session[:feed_status] = params[:feed_status]
	end
	
	unless params[:category_filter].nil?
	  session[:category_filter] = params[:category_filter]
	end
	
	@feed_items = current_user.feed(session[:feed_status], session[:category_filter])
    respond_to do |format|
	  format.js { render :layout => false }
	end 
  end
end
