class PostActionsController < ApplicationController
  
  def create
    model = params[:type].constantize
    @action = model.new(:user_id => current_user, :post_id => params[:post_id])
	@feed_item = Post.find(params[:post_id])
	if @action.save
	  respond_to do |format|
	    case @action.type
		  when "Like"
	        format.js { render :layout => false, :action => "likes" }
		  when "Favorite"
		    format.js { render :layout => false, :action => "favorites" }
		end
	  end
    end
  end
  
  def destroy
    @action = current_user.post_actions.find(params[:id])
	@feed_item = Post.find(@action.post_id)
	@action.destroy
    respond_to do |format|
	  case @action.type
		  when "Like"
	        format.js { render :layout => false, :action => "likes" }
		  when "Favorite"
		    format.js { render :layout => false, :action => "favorites" }
	  end
	end
  end
end