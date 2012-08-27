class PostsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user, only: :destroy
  
  def create
    @post = current_user.posts.build(params[:post])
	
	if params[:commit] == "Rekast"
	  @post.rekast = true
	  #TODO: add a class in before the href to match a new regex - use that to send emails about rekasted posts
	  @post.content = params[:share_content] + '<br /><br />' + @post.content + ' (Rekasted via <a href="users/' + params[:original_author] + '">' + User.find(params[:original_author]).name + '</a>)'
	end
	
    if @post.save
	  @feed_items = current_user.feed(session[:feed_status], session[:category_filter], session[:sort_order])
	  unless @feed_items.nil?
	    @feed_items = @feed_items.paginate(page: params[:page], per_page: 10)
	  end
	  tagged_users = @post.content.scan(/<a href="users\/(\d*)/).flatten
      tagged_users.each do |user|
	    #Delayed_job version of the mailer below - commenting out so heroku does not use BG process
        #NotificationMailer.delay.tag_notification(@post, User.find(user))
		NotificationMailer.tag_notification(@post, User.find(user)).deliver
	  end
    else
      @feed_items = []
      render 'static_pages/home'
    end
	@post = current_user.posts.build(params[:post])
  end
  
  def show
    @feed_items = Post.where("id = ?", params[:id]).includes(:user, {:comments => :user}, :category).paginate(page: params[:page], per_page: 10)
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
