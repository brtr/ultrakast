module FriendshipsHelper

  def friendship_link(user)
    if current_user == user
	  return
	end
    @friendship = current_user.friendships.find_by_friend_id(user.id)
	if @friendship.nil?
	  link_to("Add Friend", friendships_path(:friend_id => user), :method => :post)
	else
	  link_to("unfriend", @friendship, :method => :delete)
	end
  end
 

end
