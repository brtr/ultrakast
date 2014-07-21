module UsersHelper

  # Set profile pic sizes
  def avatar_for(user, options = { class: "avatar", size: "normal" })
    case options[:size]
      when "square"
        width = 50
        height = 50
      when "normal"
        width = 100
        height = 100
      when "small"
        width = 50
        height = 50
      when "large"
        width = 200
        height = 200
      when "medium"
        width = 50
        height = 60
    end
    # If user is a FB user, use their profile pic
	  if user.provider == "facebook"
      facebook_id = user.uid
      if options[:size] == "square"
        image_url = "http://graph.facebook.com/#{facebook_id}/picture?type=square"
      else
        image_url = "http://graph.facebook.com/#{facebook_id}/picture?height=#{height}&width=#{width}&type=square"
      end  
  	# Otherwise, use the user's uploaded image *or the default if they have not uploaded an image)
    else
      if user.avatar_file_name.nil?
        if options[:size] == 'medium'
          image_url = "default_avatar_square.gif"
        else
          image_url = "default_avatar_#{options[:size]}.gif"
        end
      else
        image_url = user.avatar(options[:size])
      end    
    end
    image_tag(image_url, alt: user.name, class: options[:class])
  end
end
