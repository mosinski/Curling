# encoding: UTF-8
class UsersController < ApplicationController
require 'net/ftp'

  def index
   if current_user
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
    else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
    end
  end


  def show
    if current_user
    @user = User.find(params[:id])
    @comments = Comment.find_all_by_user_id(@user.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
    else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
    end
  end


  def new
   if current_user
    redirect_to root_url, :notice => 'Informacja! Wyloguj się aby dokonać rejestracji'
   else
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
   end
  end


  def edit
    if current_user
    @user = User.find(params[:id])
       if (current_user.role == 'admin' && @user.role != "admin")||(current_user.username == @user.username)
	else
  	redirect_to root_url, :notice => t('errors.messages.permissions')
  	end
    else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
    end
  end


  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save_without_session_maintenance 
        format.html { redirect_to( root_url, :notice => '<h4>Informacja!</h4> Konto zarejestrowane!.<br>Twoje konto czeka teraz na potwierdzenie przez Administratora.') }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
   if current_user
    @user = User.find(params[:id])
       if (current_user.role == 'admin' && @user.role != "admin")||(current_user.username == @user.username)

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: '<h4>Informacja!</h4> Twoje konto zostało pomyślnie zaktualizowane.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
	else
  	redirect_to root_url, :notice => t('errors.messages.permissions')
  	end
    else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
    end
  end


  def destroy
    if current_user
    	@user = User.find(params[:id])
       	  if (current_user.role == 'admin' && @user.role != "admin")||(current_user.username == @user.username)
    		@user.destroy

    		respond_to do |format|
      		  format.html { redirect_to users_url }
      		  format.json { head :no_content }
    		end
	  else
  		redirect_to root_url, :notice => t('errors.messages.permissions')
  	  end
    else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
    end
  end

  def potwierdz
    @user = User.find(params[:id])
    if @user.potwierdzenie == 0 && current_user.role == "admin"
    @user.increment!(:potwierdzenie)
    ConfirmationMailer.confirmation_sender(@user).deliver
    end
    redirect_to users_path, :notice => 'Informacja! Użytkownik został potwierdzony'
  end

  def odwolaj
    @user = User.find(params[:id])
    if @user.potwierdzenie == 1 && current_user.role == "admin"
    @user.decrement!(:potwierdzenie)
    end
    redirect_to users_path, :notice => 'Informacja! Użytkownik został odwołany'	
  end

  def upload_avatar
    @user = User.find(params[:id])
    file = params[:file]
    if file != nil && file.original_filename.end_with?('.jpg','.JPG','.png','.PNG','.gif','.GIF')
    file.original_filename = file.original_filename.gsub(/\s+/, "")
    if file.size < 100.kilobytes
    ftp = Net::FTP.new('FTP.gdanskcurlingclub.pl')
    ftp.passive = true
    ftp.login(user = "avatars@gdanskcurlingclub.pl", passwd = ENV['ftp_avatar_password'])
    ftp.storbinary("STOR " + file.original_filename, StringIO.new(file.read), Net::FTP::DEFAULT_BLOCKSIZE)
    ftp.quit()
    @user.avatar = "http://avatars.gdanskcurlingclub.pl/"+file.original_filename
    @user.save_without_session_maintenance
    redirect_to @user, :notice => 'Gratulacje!<br>Avatar został zmieniony !'
    else
    redirect_to @user, :notice => 'Informacja!<br>Avatar jest za duże max 100KB !'
    end
    else
    redirect_to @user, :notice => 'Informacja!<br>Nie wybrano zdjęcia lub rozszerzenie jest niepoprawne!'
    end
    
  end

  def reset_avatar
    @user = User.find(params[:id])
    @user.avatar = "/avatar.jpg"
    @user.save_without_session_maintenance

    redirect_to @user, :notice => 'Informacja! Avatar zresetowany'
  end

end
