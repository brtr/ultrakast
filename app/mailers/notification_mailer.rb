class NotificationMailer < ActionMailer::Base
  
  def tag_notification(post, user)
    @post = post
    @user = user
	  mail(:to => "ultrakast@41northstudios.com", :subject => user.name + ", " + post.user.name + " has tagged you in a post!", :from => "ultrakast@41northstudios.com", :content_type => "text/html")
  end
  
  def rekast_notification(post, user)
    @post = post
    @user = user
	  mail(:to => "ultrakast@41northstudios.com", :subject => user.name + ", " + post.user.name + " has rekasted one of your posts!", :from => "ultrakast@41northstudios.com", :content_type => "text/html")
  end
  
  def friend_notification(friend, user)
    @friend = friend
    @user = user
    mail(:to => "ultrakast@41northstudios.com", :subject => user.name + ' has sent you a friend request.', :from => "ultrakast@41northstudios.com", :content_type => "text/html")
  end
end

#TODO: Change email addresses from 41N to user's email