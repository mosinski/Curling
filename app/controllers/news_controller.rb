# encoding: UTF-8
class NewsController < ApplicationController
  def index
    @news = News.paginate(:page => params[:page], :per_page => 10, :order => 'created_at DESC').search(params[:search], params[:page])
    @albumy_z_news = Album.find_all_by_przydzial("news")

    respond_to do |format|
      format.html
      format.json { render json: @news }
      format.atom
      format.xml  { render :xml => @news }  
    end
  end

  def show
    @news = News.find(params[:id])
    @albumy_z_news = Album.find_all_by_przydzial("news")
    @album = @albumy_z_news.detect{|w| w.przydzial_id == @news.id}
    @all_comments = @news.root_comments

    respond_to do |format|
      format.html
      format.json { render json: @news }
    end
  end

  def new
   if current_user
    if current_user.role == "admin"
      @news = News.new

      respond_to do |format|
        format.html
        format.json { render json: @news }
      end
    else
      redirect_to root_url, flash: {error: t('errors.messages.permissions')}
    end
   else
     redirect_to :login, flash: {notice: t('errors.messages.login_to_see')}
   end
  end

  def edit
   if current_user
    if current_user.role == "admin"
      @news = News.find(params[:id])
    else
      redirect_to root_url, flash: {error: t('errors.messages.permissions')}
    end
   else
     redirect_to :login, flash: {notice: t('errors.messages.login_to_see')}
   end
  end

  def create
   if current_user
    if current_user.role == "admin"
      @news = News.new(params[:news])

      respond_to do |format|
        if @news.save
          format.html { redirect_to @news, flash: {success: 'Gratulacje! Stworzono Aktualność Ogólną'}}
          format.json { render json: @news, status: :created, location: @news }
        else
          format.html { render action: "new" }
          format.json { render json: @news.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_url, flash: {error: t('errors.messages.permissions')}
    end
   else
     redirect_to :login, flash: {notice: t('errors.messages.login_to_see')}
   end
  end

  def update
   if current_user
    if current_user.role == "admin"
      @news = News.find(params[:id])

      respond_to do |format|
        if @news.update_attributes(params[:news])
          format.html { redirect_to @news, flash: {success: 'Gratulacje! Zaktualizowano Aktualność Ogólną'}}
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @news.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_url, flash: {error: t('errors.messages.permissions')}
    end
   else
     redirect_to :login, flash: {notice: t('errors.messages.login_to_see')}
   end
  end

  def destroy
   if current_user
    if current_user.role == "admin"
      @news = News.find(params[:id])
      @all_comments = @news.comment_threads
      @all_comments.each {|r| r.destroy }
      @news.destroy

      respond_to do |format|
        format.html { redirect_to news_index_url, flash: {notice: 'Informacja! Usunięto Aktualność Ogólną wraz z wszystkimi komentarzami!'}}
        format.json { head :no_content }
      end
    else
      redirect_to root_url, flash: {error: t('errors.messages.permissions')}
    end
   else
     redirect_to :login, flash: {notice: t('errors.messages.login_to_see')}
   end
  end

  def add_comment
    @news = News.find(params[:id])

    if (current_user && params[:komentarz] != nil && params[:komentarz] != "") ||
       (params[:guest_name] != nil && params[:guest_name] != "" && params[:komentarz] != nil && params[:komentarz] != "")

      if current_user
        @user_who_commented = current_user
        @comment_body = params[:komentarz]
      else
        @user_who_commented = User.find_by_username("Gosc")
        @comment_body = params[:guest_name]+"\n"
        @comment_body += params[:komentarz]
      end

      if (params[:guest_name] != "Administrator") && (params[:guest_name] != "administrator") && (params[:guest_name] != "Moderator") && (params[:guest_name] != "moderator")
        if @comment_body.length < 500

          @comment_reply = params[:parrent_id]
          @comment = Comment.build_from( @news, @user_who_commented.id, @comment_body )
          @comment.save if @news.id != 13

          if @comment_reply != nil && @comment_reply != ""
            @parent = Comment.find(@comment_reply)
            @comment.move_to_child_of(@parent)
          end

          redirect_to @news, flash: {success: 'Gratulacje! Dodano nowy komentarz!'}
        else
          redirect_to @news, flash: {error: 'Uwaga! Za długa treść komentarza!'}
        end
      else
        redirect_to @news, flash: {error: 'Uwaga! Niedozwolony Nick!'}
      end
    else
      redirect_to @news, flash: {error: 'Uwaga! Nie podano treści komentarza lub nick-u!'}
    end
  end

  def destroy_comment
    if current_user
      if current_user.role == 'admin'
        @comment = Comment.find(params[:id])

        if @comment.has_children?
          @comment.children.each {|r| r.destroy}
        end

        @comment.destroy
        redirect_to :back, flash: {notice: 'Informacja! Usunięto komentarz/e!'}

      else
        redirect_to root_url, flash: {error: t('errors.messages.permissions')}
      end
    else
      redirect_to :login, flash: {notice: t('errors.messages.login_to_see')}
    end
  end
end
