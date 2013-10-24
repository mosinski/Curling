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
	   format.xml { render :xml => @user_session, :status => :created, :location => @user_session }
          else
	   @user_session = UserSession.find
	   @user_session.destroy
	   format.html { redirect_to(root_url, flash: {notice: "<h4>Uwaga!</h4> Użytkownik <u>niepotwierdzony</u> przez Administratora.<br>O potwierdzeniu zostaniesz poinformowany na maila podanego przy rejestracji."})}
	   format.xml { head :ok }
	  end
	 else
	   format.html { render :action => "new" }
	   format.xml { render :xml => @user_session.errors, :status => :unprocessable_entity }
	 end
	end
end
 
def destroy
  @user_session = UserSession.find
  @user_session.destroy if @user_session != nil
  reset_session
 
	respond_to do |format|
	   format.html { redirect_to(root_url, flash: {notice: "Informacja! Użytkownik wylogowany"}) }
	   format.xml { head :ok }
	end
end
end
