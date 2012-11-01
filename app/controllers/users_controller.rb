class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :edit, :update]

  #new, create, edit, update, and destroy methods handled by Devise - devise/registrations_controller.rb
  
  def index
    @users = User.search(params[:search], params[:search_type])
  end
  
  def show
    @user = User.find(params[:id])
    @categories = @user.categories
    session[:feed_status] = "user"
    session[:category_filter] = "all"
    session[:filter_title] = ""
    session[:selected_category] = "all"
    session[:sort_order] = "recent"
    session[:user] = @user.id
    @feed_items = @user.feed(session[:feed_status], session[:category_filter], session[:sort_order]).paginate(page: session[:page], per_page: 10)
    
    
    @post = current_user.posts.build(params[:post])
    @reload = true
  end
  
  def live_search
    @users = current_user.friends.where("(UPPER(first_name) LIKE UPPER(?)) OR (UPPER(last_name) LIKE UPPER(?))", "%#{params[:searchString]}%", "%#{params[:searchString]}%")
    render :layout => false
  end
end
