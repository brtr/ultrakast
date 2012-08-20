class NotificationMailer < ActionMailer::Base
  def tag_notification(post, user)
    @post = post
    @user = user
	  mail(:to => "ultrakast@41northstudios.com", :subject => user.name, :from => "ultrakast@41northstudios.com", :content_type => "text/html")
  end
end
