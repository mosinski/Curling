class ConfirmationMailer < ActionMailer::Base
    default :from => "Gdansk Curling Club <mosinski.blog.newsletter@gmail.com>" , :content_type => "multipart/mixed"
  def confirmation_sender(user)
    @user = user  
    mail(:to => user.email, :subject => "Potwierdzenie Konta")  
  end
end
