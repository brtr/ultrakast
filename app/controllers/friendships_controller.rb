class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
	if @friendship.save
	  @inverse = User.find(params[:friend_id]).friendships.build(:friend_id => current_user.id)
	  if @inverse.save
	    flash[:success] = "Friend added!"
	    redirect_to root_path
	  else
	    flash[:error] = "Unable to complete both sides of relationship"
		Friendship.find(@friendship.id).destroy
		redirect_to root_path
	  end
	else
	  flash[:error] = "Unable to add friend"
	  redirect_to root_path
	end
  end
  
  def destroy
    @friendship = current_user.friendships.find(params[:id])
	@friendship.destroy
	@inverse = User.find(@friendship.friend_id).friendships.find_by_friend_id(current_user.id)
	@inverse.destroy
	flash[:success] = "Removed friend"
	redirect_to current_user
  end
end
