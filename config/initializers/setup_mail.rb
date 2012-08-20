ActionMailer::Base.smtp_settings = {
  :address				=> "mail.41northstudios.com",
  :port					=> 587,
  :domain				=> "41northstudios.com",
  :user_name			=> "ultrakast@41northstudios.com",
  :password				=> "ultrakast",
  :authentication		=> "plain",
  :openssl_verify_mode  => 'none',
  :enable_starttls_auto => true
}