class NotificationMailer < ActionMailer::Base
  def test_email(post, user)
    @post = post
    @user = user
	  mail(:to => "jcarmstrong@gmail.com", :subject => user.name, :from => "paypaldev@41northstudios.com", :content_type => "text/html")
  end
end
