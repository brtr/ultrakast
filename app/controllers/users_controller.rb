class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update]

  def new
	@user = User.new
	@categories = Category.roots
  end
  
  def index
	@users = User.all
  end
  
  def show
	  @user = User.find(params[:id])
	  @categories = @user.categories
	  @posts = @user.posts
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
  
  private
	
	  def correct_user
	    @user = User.find(params[:id])
	    #redirect_to(root_path) unless current_user?(@user)
	  end
  
end
