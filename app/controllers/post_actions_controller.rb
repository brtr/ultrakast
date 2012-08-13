class PostActionsController < ApplicationController
  
  def create
  #This needs to be all kindsa refactored - need JS for comments
    model = params[:type].constantize
    @action = model.new(:user_id => current_user.id, :post_id => params[:post_id])
	if @action.type == "Comment"
	  @action.content = params[:comment][:content]
	  @action.save
	  @feed_item = Post.find(params[:post_id])
	else #change to end
	
	@feed_item = Post.find(params[:post_id])
	if @action.save
	  respond_to do |format|
	    @feed_item.reload
	    case @action.type
		  
		  #when "Comment"
		  #  flash[:success] = "Comment saved!"
		  #	redirect_to root_path
		  when "Like"
	        format.js { render :layout => false, :action => "likes" }
		  when "Favorite"
		    format.js { render :layout => false, :action => "favorites" }
		end
	  end
    end
	end #take out
  end
  
  def destroy
    @action = current_user.post_actions.find(params[:id])
	@feed_item = Post.find(@action.post_id)
	@action.destroy
      respond_to do |format|
	    @feed_item.reload
	    case @action.type
		  when "Comment"
		    format.js { render :layout => false, :action => "comments" }
		  when "Like"
	        format.js { render :layout => false, :action => "likes" }
		  when "Favorite"
		    format.js { render :layout => false, :action => "favorites" }
	    end
	  end
  end
end