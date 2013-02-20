ActionMailer::Base.smtp_settings = {
#TODO: CONFIGURE THESE TO A PRODUCTION MAILSERVER
  :address				      => "smtpout.secureserver.net",
  :port					        => 25,
  :domain				        => "ultrakast.com",
  :user_name			      => "system@ultrakast.com",
  :password				      => "Ultrakast1",
  :authentication		    => "plain",
  :openssl_verify_mode  => 'none',
  :enable_starttls_auto => true
}