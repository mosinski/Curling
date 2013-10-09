# encoding: UTF-8
class TeamsEmailsController < ApplicationController
  def new
   if current_user
    if current_user.role == "admin"
    @teams_email = TeamsEmail.new

    respond_to do |format|
      format.html
      format.json { render json: @teams_email }
    end
    else
  	redirect_to root_url, :notice => t('errors.messages.permissions')
    end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end

  def edit
   if current_user
    if current_user.role == "admin"
    @teams_email = TeamsEmail.find(params[:id])
    else
  	redirect_to root_url, :notice => t('errors.messages.permissions')
    end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end

  def create
   if current_user
    if current_user.role == "admin"
    @teams_email = TeamsEmail.new(params[:teams_email])

    respond_to do |format|
      if @teams_email.save
        format.html { redirect_to root_url, notice: "Gratulacje! Drużyna '#{@teams_email.nazwa}' pomyślnie dodana do listy." }
        format.json { render json: @teams_email, status: :created, location: @teams_email }
      else
        format.html { render action: "new" }
        format.json { render json: @teams_email.errors, status: :unprocessable_entity }
      end
    end
    else
  	redirect_to root_url, :notice => t('errors.messages.permissions')
    end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end

  def update
   if current_user
    if current_user.role == "admin"
    @teams_email = TeamsEmail.find(params[:id])

    respond_to do |format|
      if @teams_email.update_attributes(params[:teams_email])
        format.html { redirect_to root_url, notice: "Gratulacje! Drużyna '#{@team_email.nazwa}' pomyślnie zaktualizowana." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @teams_email.errors, status: :unprocessable_entity }
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
    if current_user.role == "admin"
    @teams_email = TeamsEmail.find(params[:id])
    @teams_email.destroy

    respond_to do |format|
      format.html { redirect_to root_url, notice: "Gratulacje! Pomyślnie usunięto drużynę." }
      format.json { head :no_content }
    end
    else
  	redirect_to root_url, :notice => t('errors.messages.permissions')
    end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end
end
