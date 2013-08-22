# encoding: UTF-8
class MediaController < ApplicationController
  # GET /media
  # GET /media.json
  def index
    @media = Medium.all
    @medium = Medium.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @media }
    end
  end

  # GET /media/1/edit
  def edit
   if current_user
    if current_user.role == "admin"
    	@medium = Medium.find(params[:id])
    else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
    end
   else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
  end

  # POST /media
  # POST /media.json
  def create
   if current_user
    if current_user.role == "admin"
    @medium = Medium.new(params[:medium])

    respond_to do |format|
      if @medium.save
        format.html { redirect_to media_path, notice: 'Informacja! Link w Media o Nas został pomyślnie stworzony' }
        format.json { render json: @medium, status: :created, location: @medium }
      else
        format.html { render action: "new" }
        format.json { render json: @medium.errors, status: :unprocessable_entity }
      end
    end
    else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
    end
   else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
  end

  # PUT /media/1
  # PUT /media/1.json
  def update
   if current_user
    if current_user.role == "admin"
    @medium = Medium.find(params[:id])

    respond_to do |format|
      if @medium.update_attributes(params[:medium])
        format.html { redirect_to @medium, notice: 'Informacja! Link w Media o Nas został pomyślnie zaktualizowany' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @medium.errors, status: :unprocessable_entity }
      end
    end
    else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
    end
   else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
  end

  # DELETE /media/1
  # DELETE /media/1.json
  def destroy
   if current_user
    if current_user.role == "admin"
    @medium = Medium.find(params[:id])
    @medium.destroy

    respond_to do |format|
      format.html { redirect_to media_url }
      format.json { head :no_content }
    end
  end
    else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
    end
   else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
end
