class UsersController < ApplicationController
  def new
	@user = User.new
	@categories = Category.roots
	
  end
  
  def show
	@user = User.find(params[:id])
	@categories = @user.categories
  end
  
  def create
    @user = User.new(params[:user])
	  if @user.save
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
      redirect_to @user
    else
      render 'edit'
    end
  end
end
