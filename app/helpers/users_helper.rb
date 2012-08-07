module UsersHelper

  def avatar_for(user, options = { size: "normal" })
    if user.provider == "Facebook"
      facebook_id = user.uid
      size = options[:size]
  	  image_url = "http://graph.facebook.com/#{facebook_id}/picture?type=#{size}"
    else
      if user.avatar_file_name.nil?
        image_url = "default_avatar.gif"
      else
        image_url = user.avatar(:normal)
      end    
    end
    image_tag(image_url, alt: user.name, class: "avatar")
  end
end
