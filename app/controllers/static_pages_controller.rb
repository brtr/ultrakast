class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @post = current_user.posts.build
      @feed_items = current_user.feed
    end
  end
  
  def switch_feed
    @feed_status = params[:feed]
    if @feed_status == "public"
	  @feed_items = current_user.public_feed
	else
	  @feed_items = current_user.feed
	end
    respond_to do |format|
	  format.js { render :layout => false }
	end 
  end
end
