class LikesController < ApplicationController
  
  def create
    @like = current_user.likes.build(:post_id => params[:post_id])
	@feed_item = Post.find(params[:post_id])
	if @like.save
	  respond_to do |format|
	    format.js { render :layout => false, :action => "likes" }
	  end
    end
  end
  
  def destroy
    @like = current_user.likes.find(params[:id])
	@feed_item = Post.find(@like.post_id)
	@like.destroy
    respond_to do |format|
	  format.js { render :layout => false, :action => "likes"  }
	end
  end

end