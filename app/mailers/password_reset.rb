class PasswordReset < ActionMailer::Base
    default :from => "Gdansk Curling Club <admin@m1l05z.pl>" , :content_type => "multipart/mixed"
  def password_sender(user,nowehaslo)
    @user = user
    @password = nowehaslo

    mail(:to => @user.email, :subject => "Reset Hasla")  
  end
end
