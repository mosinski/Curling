# encoding: UTF-8
class UserSessionsController < ApplicationController

  def new
    if current_user
      redirect_to root_path, flash: {alert: 'Informacja! Jesteś aktualnie zalogowany!'}
    else
      @user_session = UserSession.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml { render :xml => @user_session }
      end
    end
  end

  def create
    @user_session = UserSession.new(params[:user_session])

    respond_to do |format|
      if @user_session.save
        @username = User.find_by_username(current_user.username)
        if @username.potwierdzenie == 1
          format.html { redirect_to(root_url,  flash: {success: "Informacja! Użytkownik zalogowany"}) }
        else
          @user_session = UserSession.find
          @user_session.destroy
          format.html { redirect_to(root_url, flash: {notice: "<h4>Uwaga!</h4> Użytkownik <u>niepotwierdzony</u> przez Administratora.<br>O potwierdzeniu zostaniesz poinformowany na maila podanego przy rejestracji."})}
        end
      else
        format.html { render :action => "new" }
      end
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy if @user_session != nil
    reset_session

    respond_to do |format|
      format.html { redirect_to(root_url, flash: {notice: "Informacja! Użytkownik wylogowany"}) }
    end
  end

  def fast_login
    if current_user
      @user = User.find(current_user.id)
      @user.facebook_id = request.env['omniauth.auth'][:info][:nickname]
      @user.save

      respond_to do |format|
        format.html { redirect_to(edit_user_path(current_user.id), flash: {success: "Informacja! Konto FB połączone"}) }
      end
    else
      @user = User.find_by_facebook_id(request.env['omniauth.auth'][:info][:nickname])

      if @user != nil
        @user_sessions = UserSession.new(@user, true)
        @user_sessions.save

        respond_to do |format|
          format.html { redirect_to(root_url, flash: {success: "Informacja! Użytkownik zalogowany"}) }
        end
      else
        respond_to do |format|
          format.html { redirect_to(root_url, flash: {error: "Uwaga! Użytkownik nieznaleziony"}) }
        end
      end
    end
  end
end
