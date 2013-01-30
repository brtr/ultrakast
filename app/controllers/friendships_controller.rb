class FriendshipsController < ApplicationController

  def create
    friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    friendship.status = "requested"
    if friendship.save
      friend = User.find(params[:friend_id])
      inverse = friend.friendships.build(:friend_id => current_user.id)
      inverse.status = "pending"
      if inverse.save
        flash[:success] = "Friend request sent"
        alert = friend.alerts.build
        alert.friend_id = current_user.id
        alert.content = "You have received a friend request from <a href=\"/users/#{current_user.id}\">#{current_user.name}</a>. <a href=\"/friendships/process?decision=approve&user=#{friend.id}&friend=#{current_user.id}\">Accept</a> or <a href=\"/friendships/process?decision=reject&user=#{friend.id}&friend=#{current_user.id}\">Reject</a>"
        alert.save
        #NotificationMailer.delay.friend_notification(friend, current_user)
        NotificationMailer.friend_notification(friend, current_user).deliver
        redirect_to users_path
      else
        flash[:error] = "Unable to complete both sides of relationship"
        Friendship.find(friendship.id).destroy
        redirect_to users_path
      end
    else
      flash[:error] = "Unable to add friend"
      redirect_to users_path
    end
  end
  
  def process_friendship     
    user = User.find_by_id(params[:user])
    if current_user != user
      redirect_to root_path and return
    end
    if params[:decision] == "approve"
      friendship = Friendship.where("user_id = ? AND friend_id = ?", params[:user], params[:friend]).first
      friendship.update_column(:status, "approved")
      inverse = Friendship.where("user_id = ? AND friend_id = ?", params[:friend], params[:user]).first
      inverse.update_column(:status, "approved")
    end
    if params[:decision] == "reject"
      Friendship.where("user_id = ? AND friend_id = ?", params[:user], params[:friend]).first.destroy
      Friendship.where("user_id = ? AND friend_id = ?", params[:friend], params[:user]).first.destroy
    end
    alert = Alert.where("user_id = ? AND friend_id = ?", params[:user], params[:friend]).first
    unless alert.nil?
      alert.destroy
    end  
    redirect_to root_path
  end
  
  def destroy
    friendship = current_user.friendships.find(params[:id])
    friendship.destroy
    inverse = User.find(friendship.friend_id).friendships.find_by_friend_id(current_user)
    inverse.destroy
    flash[:success] = "Removed friend"
    redirect_to users_path
  end
end