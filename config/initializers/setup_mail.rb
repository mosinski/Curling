ActionMailer::Base.smtp_settings = {  
  :address              => "s4.masternet.pl",  
  :port                 => 465,
  :user_name            => "admin@m1l05z.pl",  
  :password             => "Zi3lonych0mik",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}
ActionMailer::Base.default_url_options[:host] = "www.blog.m1l05z.pl"
