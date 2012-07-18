class PostsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user, only: :destroy
  
  def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      session[:category_filter] = params[:post][:category_id]
	    @feed_items = current_user.feed(session[:feed_status], session[:category_filter])
	    unless @feed_items.nil?
	      @feed_items = @feed_items.paginate(page: params[:page], per_page: 10)
	    end
	    @filter_title = filter_title(Category.find(params[:post][:category_id]).name)
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
  
  def destroy
    @post.destroy
    redirect_to root_path
  end
  
  
  private
  
    def correct_user
      @post = current_user.posts.find_by_id(params[:id])
      redirect_to root_path if @post.nil?
    end
  
end
