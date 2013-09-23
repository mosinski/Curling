# encoding: UTF-8
class AboutsController < ApplicationController

  def edit
   if current_user
    if current_user.role == "admin"
      @about = About.find(params[:id])
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
       @about = About.find(params[:id])

       respond_to do |format|
         if @about.update_attributes(params[:about])
           format.html { redirect_to @about, notice: "Gratulacje! Strona 'O nas' pomyślnie zaktualizowana'" }
           format.json { head :no_content }
         else
           format.html { render action: "edit" }
           format.json { render json: @about.errors, status: :unprocessable_entity }
         end
       end
    else
  	redirect_to root_url, :notice => t('errors.messages.permissions')
    end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end

end
