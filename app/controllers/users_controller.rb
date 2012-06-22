class UsersController < ApplicationController
  def new
	@user = User.new
	@categories = Category.roots
	
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
    @user = User.find(params[:id])
  end
  
  def update
    params[:user][:category_ids] ||= []
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated!"
	  sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
end
