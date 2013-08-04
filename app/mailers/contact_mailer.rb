class ContactMailer < ActionMailer::Base
    default :from => "Gdansk Curling Club <mosinski.blog.newsletter@gmail.com>" , :content_type => "multipart/mixed"
  def message_sender(name,email,message)
    @name = name
    @email = email
    @message = message

    mail(:to => "mylosz@yahoo.pl", :subject => "Kontakt ze Strony")  
  end
end
