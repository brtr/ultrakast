module UsersHelper

  def avatar_for(user, options = { size: "normal" })
    facebook_id = user.uid
    size = options[:size]
	  facebook_url = "http://graph.facebook.com/#{facebook_id}/picture?type=#{size}"
  	image_tag(facebook_url, alt: user.name, class: "avatar")
  end
end
