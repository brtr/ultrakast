ActionMailer::Base.smtp_settings = {
#TODO: CONFIGURE THESE TO A PRODUCTION MAILSERVER
  :address				      => "pop.secureserver.net",
  :port					        => 587,
  :domain				        => "ultrakast.com",
  :user_name			      => "system@4ultrakast.com",
  :password				      => "Ultrakast1",
  :authentication		    => "plain",
  :openssl_verify_mode  => 'none',
  :enable_starttls_auto => true
}