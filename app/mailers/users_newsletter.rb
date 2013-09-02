class UsersNewsletter < ActionMailer::Base
    default :from => "Gdansk Curling Club <gdanskcurlingclub@gmail.com>" , :content_type => "multipart/mixed"
  def users_newsletter_sender(user,dashboard)
    @user = user
    @aktualnosc = dashboard

    mail(:to => @user.email, :subject => "Nowa Aktualnosc Klubowa")  
  end
end
