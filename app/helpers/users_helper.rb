module UsersHelper

  def avatar_for(user, options = { size: "normal" })
    size = options[:size]
	if user.provider == "Facebook"
      facebook_id = user.uid
  	  image_url = "http://graph.facebook.com/#{facebook_id}/picture?type=#{size}"
    else
      if user.avatar_file_name.nil?
        image_url = "default_avatar_#{size}.gif"
      else
        image_url = user.avatar(:normal)
      end    
    end
    image_tag(image_url, alt: user.name, class: "avatar")
  end
end
