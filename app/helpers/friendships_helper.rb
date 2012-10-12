module FriendshipsHelper
  def friendship_link(user)
    if current_user == user
      return
    end
    friendship = current_user.friendships.find_by_friend_id(user.id)
    if friendship.nil?
      link_to("Add Friend", friendships_path(:friend_id => user), :method => :post)
    elsif friendship.status == "requested"
      "Friend request pending"
    elsif friendship.status == "pending"
      "Friend request pending - <a href=\"/friendships/process?decision=approve&user=#{current_user.id}&friend=#{user.id}\">Accept</a> or <a href=\"/friendships/process?decision=reject&user=#{current_user.id}&friend=#{user.id}\">Reject</a>".html_safe
    else
      link_to("Unfriend", friendship, :method => :delete)
    end
  end
end
