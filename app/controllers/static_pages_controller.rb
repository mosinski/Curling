# encoding: UTF-8
class StaticPagesController < ApplicationController

 def start
    @news_last = News.last(3).reverse
    @images_last = Image.last(3).reverse
    @tournament_last = Tournament.last

    respond_to do |format|
      format.html # start.html.erb
      format.json { render json: @static_page }
    end
  end

 def galeria
    @albums = Album.paginate(:page => params[:page], :per_page => 6, :order => 'termin DESC')

    
    respond_to do |format|
      format.html # galeria.html.erb
      format.json { render json: @static_page }
    end
  end

 def about
    @about = About.last
    
    if @about == nil
     @about = About.create
     @about.tekst_pl = ""
     @about.tekst_en = ""
     @about.save
    end
    respond_to do |format|
      format.html # about.html.erb
      format.json { render json: @static_page }
    end
  end
  
  def rss_comments
    @news = News.all
    @komentarze = Comment.find_all_by_commentable_type("News").reverse
    @users = User.all

    if @komentarze.present?
    	respond_to do |format|
      	  format.html # show.html.erb
      	  format.json { render json: @komentarze }
      	  format.atom     # index.atom.builder
      	  format.xml  { render :xml => @komentarze }  
    	end
    else
      redirect_to root_url, flash: {notice: "Informacja! <br>Aktualnie brak komentarzy do wyświetlenia ;("}
    end
  end

 def resethasla
    if current_user
        redirect_to root_url, flash: {notice: 'Informacja! <br>Aktualnie jesteś zalogowany na konto<br>Wyloguj się!'}
    else
    	respond_to do |format|
      		format.html # resethasla.html.erb
      		format.json { render json: @static_page }
    	end
    end
  end


 def admin_panel
    if current_user
    	if current_user.role == "admin"
    	@users = User.find_all_by_potwierdzenie(1).select {|s| s.role != "admin"}
    	@users_waiting = User.find_all_by_potwierdzenie(0).select {|s| s.username != "Gosc"}
    	@users_login = User.all.select {|s| s.login_count > 0 && s.last_login_at != nil && s.last_login_at.strftime("%Y-%m-%d") == Time.now.strftime("%Y-%m-%d")}
    	@news = News.all
    	@news_comments = Comment.find_all_by_commentable_type("News")
	@dashboard = Dashboard.all
    	@dashboard_comments = Comment.find_all_by_commentable_type("Dashboard")
	@albums = Album.all
	@images = Image.all
	@media = Medium.all
	@tournaments = Tournament.all
	@about = About.last
	@teams_emails = TeamsEmail.all
	
	if @about == nil
    	 @about = About.create
    	 @about.tekst_pl = ""
    	 @about.tekst_en = ""
    	 @about.save
    	end

    	respond_to do |format|
      		format.html # about.html.erb
      		format.json { render json: @static_page }
    	end
	else
  	  redirect_to root_url, flash: {error: t('errors.messages.permissions')}
  	end
    else
        redirect_to :login, flash: {notice: t('errors.messages.login_to_see')}
    end
  end

  def contact
    if simple_captcha_valid?
	@name = params[:contact_name]
	@email = params[:contact_email]
	@message = params[:contact_message]

	if @name != "" && @email != "" && @message != ""
		ContactMailer.message_sender(@name,@email,@message).deliver
		redirect_to root_url, flash: {notice: 'Informacja! Wiadomość wysłana pomyślnie dziękujemy!'}
	else
          redirect_to "/kontakt", flash: {error: 'Uwaga! Podane dane są niekompletne!'}
	end
    else
  	redirect_to "/kontakt", flash: {error: 'Uwaga! Podany kod z obrazka jest niepoprawny!'}
    end

  end

  def reset_pass
	@user = User.find_by_username(params[:user_name])
        @form_born = convert_date(params[:user], :born)
	@form_pesel = params[:user_pesel]

	if @user != nil
		if (@user.pesel == @form_pesel) && (@user.born == @form_born)
		  @nowehaslo = SecureRandom.base64(8).tr('+/=lIO0', 'pqrsxyz')
		  PasswordReset.password_sender(@user,@nowehaslo).deliver
		  @user.password = @nowehaslo
		  @user.password_confirmation = @nowehaslo
		  @user.save_without_session_maintenance 
        	  redirect_to "/resethasla", flash: {success: "Gratulacje! Nowe hasło zostało wysłane na maila!"}
		else
        	  redirect_to "/resethasla", flash: {error: 'Uwaga! Podane dane są nieprawidłowe!'}
		end
        
	else
          redirect_to "/resethasla", flash: {notice: 'Informacja! Nie znaleziono Konta lub podane dane są niekompletne!'}
	end
  end

  private
 
  def convert_date(hash, date_symbol_or_string)
    attribute = date_symbol_or_string.to_s
    return Date.new(hash[attribute + '(1i)'].to_i, hash[attribute + '(2i)'].to_i, hash[attribute + '(3i)'].to_i)   
  end

end
