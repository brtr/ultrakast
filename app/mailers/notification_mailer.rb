class NotificationMailer < ActionMailer::Base
  
  def tag_notification(post, user)
    @post = post
    @user = user
	  mail(:to => user.email, :subject => user.name + ", " + post.user.name + " has tagged you in a post!", :from => "system@ultrakast.com", :content_type => "text/html")
  end
  
  def rekast_notification(post, user)
    @post = post
    @user = user
	  mail(:to => user.email, :subject => user.name + ", " + post.user.name + " has rekasted one of your posts!", :from => "system@ultrakast.com", :content_type => "text/html")
  end
  
  def friend_notification(friend, user)
    @friend = friend
    @user = user
    mail(:to => friend.email, :subject => user.name + ' has sent you a friend request.', :from => "system@ultrakast.com", :content_type => "text/html")
  end
end
