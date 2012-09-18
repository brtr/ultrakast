class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update]

  def new
	@user = User.new
	@categories = Category.roots
  end
  
  def index
	@users = User.search(params[:search], params[:search_type])
  end
  
  def show
	  @user = User.find(params[:id])
	  @categories = @user.categories
	  session[:feed_status] = "favorites"
	  session[:user] = @user.id
	  @feed_items = @user.feed(session[:feed_status], session[:category_filter], session[:sort_order]).paginate(page: session[:page], per_page: 10)
	  @post = current_user.posts.build(params[:post])
	  @reload = true
  end
  
  def create
    @user = User.new(params[:user])
	  if @user.save
	    sign_in @user
	    redirect_to @user
	  else
	    render 'new'
	  end
  end
  
  def edit
  end
  
  def update
    params[:user][:category_ids] ||= []
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated!"
	  sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  
  def live_search
    @users = current_user.friends.where("UPPER(name) LIKE UPPER(?)", "%#{params[:searchString]}%")
    render :layout => false
  end
  
  private
	
	  def correct_user
	    @user = User.find(params[:id])
	    #redirect_to(root_path) unless current_user?(@user)
	  end

end
