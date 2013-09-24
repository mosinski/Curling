# encoding: UTF-8
class DashboardsController < ApplicationController
  # GET /dashboards
  # GET /dashboards.json
  def index
   if current_user
    @dashboards = Dashboard.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dashboards }
      if @dashboards.present?
      format.atom     # index.atom.builder
      else
      redirect_to root_url, :notice => "Informacja! <br>Aktualnie brak Aktualności Klubowych do wyświetlenia ;("
      end
      format.xml  { render :xml => @dashboards } 
    end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end

  # GET /dashboards/1
  # GET /dashboards/1.json
  def show
   if current_user
    	@dashboard = Dashboard.find(params[:id])
    	@all_comments = @dashboard.root_comments.reverse

    	respond_to do |format|
      		format.html # show.html.erb
      		format.json { render json: @dashboard }
    	end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end

  # GET /dashboards/new
  # GET /dashboards/new.json
  def new
   if current_user
    if current_user.role == "admin"
    	@dashboard = Dashboard.new

    	respond_to do |format|
      		format.html # new.html.erb
      		format.json { render json: @dashboard }
    	end
    else
  	redirect_to root_url, :notice => t('errors.messages.permissions')
    end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end

  # GET /dashboards/1/edit
  def edit
   if current_user
    if current_user.role == "admin"
    	@dashboard = Dashboard.find(params[:id])
    else
  	redirect_to root_url, :notice => t('errors.messages.permissions')
    end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end

  # POST /dashboards
  # POST /dashboards.json
  def create
   if current_user
    if current_user.role == "admin"
    @dashboard = Dashboard.new(params[:dashboard])
    @users = User.all

    	respond_to do |format|
      	  if @dashboard.save
      	   	@users.each do |user|
      	  	  UsersNewsletter.users_newsletter_sender(user, @dashboard).deliver
      	  	end
        	format.html { redirect_to @dashboard, notice: 'Gratulacje! Stworzono Aktualno&#347;&#263; Klubow&#261;' }
        	format.json { render json: @dashboard, status: :created, location: @dashboard }
      	  else
        	format.html { render action: "new" }
        	format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      	  end
    	end
    else
  	redirect_to root_url, :notice => t('errors.messages.permissions')
    end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end

  # PUT /dashboards/1
  # PUT /dashboards/1.json
  def update
   if current_user
    if current_user.role == "admin"
    @dashboard = Dashboard.find(params[:id])

    	respond_to do |format|
      	  if @dashboard.update_attributes(params[:dashboard])
        	format.html { redirect_to @dashboard, notice: 'Gratulacje! Zaktualizowano Aktualno&#347;&#263; Klubow&#261;' }
        	format.json { head :no_content }
      	  else
        	format.html { render action: "edit" }
        	format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      	  end
    	end
    else
  	redirect_to root_url, :notice => t('errors.messages.permissions')
    end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end

  # DELETE /dashboards/1
  # DELETE /dashboards/1.json
  def destroy
   if current_user
    if current_user.role == "admin"
    	@dashboard = Dashboard.find(params[:id])
    	@all_comments = @dashboard.comment_threads
    	@all_comments.each {|r| r.destroy }
    	@dashboard.destroy

    	respond_to do |format|
      	  format.html { redirect_to dashboards_url, :notice => 'Informacja! Usunięto Aktualność Klubową wraz z wszystkimi komentarzami!' }
      	  format.json { head :no_content }
    	end
    else
  	redirect_to root_url, :notice => t('errors.messages.permissions')
    end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end

  def add_comment
   if current_user
    @dashboard = Dashboard.find(params[:id])
    if params[:komentarz] != nil && params[:komentarz].length < 500
    @user_who_commented = current_user
    @comment_reply = params[:parrent_id]
    @comment = Comment.build_from( @dashboard, @user_who_commented.id, params[:komentarz] )
    @comment.save

    if @comment_reply != nil && @comment_reply != ""
    @parent = Comment.find(@comment_reply)
    @comment.move_to_child_of(@parent)
    end
    
    redirect_to @dashboard, :notice => 'Gratulacje! Dodano nowy komentarz!'
    else
    redirect_to @dashboard, :notice => 'Uwaga! Niewłaściwa długość treści komentarza! Dopuszczalna od 1 do 500 znaków.'
    end
   else
    redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end

  def destroy_comment
    if current_user
      if (current_user.role == 'admin')
    	@comment = Comment.find(params[:id])

    	if @comment.has_children?
    		@comment.children.each {|r| r.destroy}
    	end

   	@comment.destroy
    	redirect_to :back, :notice => 'Informacja! Usunięto komentarz/e!'

      else
  	redirect_to root_url, :notice => t('errors.messages.permissions')
      end
    else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
    end
  end

end
