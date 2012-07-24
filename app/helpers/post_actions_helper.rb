module PostActionsHelper

  def like_link(post)
    if post.likes_count?
      like = post.likes.find_by_user_id(current_user)
	    if like.nil?
	      link_to("Like", likes_path(:post_id => post), :method => :post, :remote => true)
	    else
	      link_to("Unlike", like, :method => :delete, :remote => true)
	   end
	else
	  link_to("Like", likes_path(:post_id => post), :method => :post, :remote => true)
	end
  end
  
  def favorite_link(user, post)
    if post.favorites_count?
      favorite = post.favorites.find_by_user_id(user.id)
	  if favorite.nil?
	    link_to((image_tag 'unfavorite.png', :height => "2.5%", :width => "2.5%"), favorites_path(:post_id => post), :method => :post, :remote => true)
	  else
	    link_to((image_tag 'favorite.png', :height => "2.5%", :width => "2.5%"), favorite, :method => :delete, :remote => true)
	  end
	else
	  link_to((image_tag 'unfavorite.png', :height => "2.5%", :width => "2.5%"), favorites_path(:post_id => post), :method => :post, :remote => true)
	end
  end
 

end