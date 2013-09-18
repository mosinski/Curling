# encoding: UTF-8
class MessagesController < ApplicationController
  
  before_filter :set_user
  
  def index
   if current_user
    if params[:mailbox] == "sent"
      @messages = current_user.sent_messages
    else
      @messages = current_user.received_messages
    end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end
  
  def show
   if current_user
    @message = Message.read_message(params[:id], current_user)
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end
  
  def new
   if current_user
    @message = Message.new

    if params[:reply_to]
      @reply_to = @user.received_messages.find(params[:reply_to])
      unless @reply_to.nil?
        @user = @reply_to.sender
        @message.to = @reply_to.sender.username
        @message.subject = "Re: #{@reply_to.subject}"
        @message.body = "\n\n_________________[Poprzednia Wiadomosc]_________________\n\n #{@reply_to.body}"
      end
    end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end
  
  def create
   if current_user
    @message = Message.new(params[:message])
    @message.sender = current_user
    @message.recipient = User.find_by_username(params[:message][:to])

    if @message.save
      redirect_to user_messages_path(current_user), :notice => 'Gratulacje! Wiadomość została wysłana!'
    else
      render :action => :new
    end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end
  
  def delete_selected
   if current_user
    if request.post?
      if params[:delete]
        params[:delete].each { |id|
          @message = Message.find(:first, :conditions => ["messages.id = ? AND (sender_id = ? OR recipient_id = ?)", id, @user, @user])
          @message.mark_deleted(@user) unless @message.nil?
        }
      flash[:notice] = "Gratulacje! Wiadomość została usunięta!"
      end
      redirect_to :back
    end
   else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
   end
  end
  
  private
    def set_user
      @user = User.find(params[:user_id])
    end
end
