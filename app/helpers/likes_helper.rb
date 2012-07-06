module LikesHelper

  def like_link(user, post)

    @like = post.likes.find_by_user_id(user.id)
	if @like.nil?
	  link_to("Like", likes_path(:post_id => post), :method => :post, :remote => true)
	else
	  link_to("Unlike", @like, :method => :delete, :remote => true)
	end
  end
 

end