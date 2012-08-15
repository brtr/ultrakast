class NotificationMailer < ActionMailer::Base
  def test_email()
	mail(:to => "jim@41northstudios.com", :subject => "test email", :from => "paypaldev@41northstudios.com")
  end
end
