class NotificationMailer < ActionMailer::Base
  def tag_notification(post, user)
    @post = post
    @user = user
	  mail(:to => "ultrakast@41northstudios.com", :subject => post.user.name + " has tagged you in a post!", :from => "ultrakast@41northstudios.com", :content_type => "text/html")
  end
end
