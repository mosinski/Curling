# encoding: UTF-8
class TournamentsController < ApplicationController
  # GET /tournaments
  # GET /tournaments.json
  def index
   if current_user
    if current_user.role == "admin"
    @tournaments = Tournament.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tournaments }
    end
    else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnień!'
    end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end

  # GET /tournaments/1
  # GET /tournaments/1.json
  def show
    @tournament = Tournament.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tournament }
    end
  end

  # GET /tournaments/new
  # GET /tournaments/new.json
  def new
   if current_user
    if current_user.role == "admin"
    @tournament = Tournament.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tournament }
    end
    else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnień!'
    end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end

  # GET /tournaments/1/edit
  def edit
   if current_user
    if current_user.role == "admin"
    @tournament = Tournament.find(params[:id])
    else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnień!'
    end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end

  # POST /tournaments
  # POST /tournaments.json
  def create
   if current_user
    if current_user.role == "admin"
    @tournament = Tournament.new(params[:tournament])

    respond_to do |format|
      if @tournament.save
        format.html { redirect_to @tournament, notice: "Gratulacje! Turniej: '#{@tournament.nazwa}' dodany pomyślnie!" }
        format.json { render json: @tournament, status: :created, location: @tournament }
      else
        format.html { render action: "new" }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
    else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnień!'
    end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
  end

  # PUT /tournaments/1
  # PUT /tournaments/1.json
  def update
   if current_user
    if current_user.role == "admin"
    @tournament = Tournament.find(params[:id])

    respond_to do |format|
      if @tournament.update_attributes(params[:tournament])
        format.html { redirect_to @tournament, notice: "Gratulacje! Turniej: '#{@tournament.nazwa}' pomyślnie zaktualizowany!" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
    else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnień!'
    end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end

  # DELETE /tournaments/1
  # DELETE /tournaments/1.json
  def destroy
   if current_user
    if current_user.role == "admin"
    @tournament = Tournament.find(params[:id])
    @tournament.destroy

    respond_to do |format|
      format.html { redirect_to tournaments_url }
      format.json { head :no_content }
    end
    else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnień!'
    end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end
end
