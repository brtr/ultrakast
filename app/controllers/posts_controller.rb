class PostsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user, only: :destroy
  
  def create
    @post = current_user.posts.build(params[:post])
  
    if params[:commit] == "Rekast"
      @post.rekast = true
      #TODO: WHAT? add a class in before the href to match a new regex - use that to send emails about rekasted posts
      @post.content = params[:rekast_content] + '<div class="rekast">' + @post.content + ' (via <a class="rekast-author" href="users/' + params[:original_author] + '">' + User.find(params[:original_author]).name + '</a>)</div>'
      original_post = Post.find(params[:post][:original_post])
      @post.image = original_post.image
    end
  
    if @post.save
      @feed_items = current_user.feed(session[:feed_status], session[:category_filter], session[:sort_order])
      unless @feed_items.nil?
        @feed_items = @feed_items.paginate(page: params[:page], per_page: 10)
      end
      tagged_users = @post.content.scan(/<a href="users\/(\d*)/).flatten
      tagged_users.each do |u|
        user = User.find(u)
        #Delayed_job version of the mailer below - comment out to force heroku to not use BG processes
        #NotificationMailer.delay.tag_notification(@post, user)        
        NotificationMailer.tag_notification(@post, user).deliver
        alert = user.alerts.build
        alert.content = "<a href=\"/users/#{current_user.id}\">#{current_user.name}</a> has tagged you in <a href=\"/posts/#{@post.id}\">a post</a>"
        alert.save
      end
      rekasted_users = @post.content.scan(/<a class="rekast-author" href="users\/(\d*)/).flatten
      rekasted_users.each do |u|
        user = User.find(u)
        #NotificationMailer.delay.rekast_notification(@post, user)
        NotificationMailer.rekast_notification(@post, user).deliver
        alert = user.alerts.build
        alert.content = "<a href=\"/users/#{current_user.id}\">#{current_user.name}</a> <a href=\"/posts/#{@post.id}\">has rekasted</a> one of your posts!"
        alert.save
      end
      @reload = params[:reload]
    else
      @feed_items = []
      render 'static_pages/home'
    end
    @post = current_user.posts.build(params[:post])
  end
  
  def show
    @feed_items = Post.where("id = ?", params[:id]).includes(:user, {:comments => :user}, :category).paginate(page: params[:page], per_page: 10)
    @post = current_user.posts.build(params[:post])
  end
  
  def destroy
    @post.destroy
    redirect_to root_path
  end
  
  private
    
    #Make sure users can only delete their own posts
    def correct_user
      @post = current_user.posts.find_by_id(params[:id])
      redirect_to root_path if @post.nil?
    end
end
