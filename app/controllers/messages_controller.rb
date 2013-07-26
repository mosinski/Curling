class MessagesController < ApplicationController
  
  before_filter :set_user
  
  def index
    if params[:mailbox] == "sent"
      @messages = current_user.sent_messages
    else
      @messages = current_user.received_messages
    end
  end
  
  def show
    @message = Message.read_message(params[:id], current_user)
  end
  
  def new
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
  end
  
  def create
    @message = Message.new(params[:message])
    @message.sender = current_user
    @message.recipient = User.find_by_username(params[:message][:to])

    if @message.save
      redirect_to user_messages_path(current_user), :notice => 'Gratulacje! Wiadomo&#347;&#263; zosta&#322;a wys&#322;ana!'
    else
      render :action => :new
    end
  end
  
  def delete_selected
    if request.post?
      if params[:delete]
        params[:delete].each { |id|
          @message = Message.find(:first, :conditions => ["messages.id = ? AND (sender_id = ? OR recipient_id = ?)", id, @user, @user])
          @message.mark_deleted(@user) unless @message.nil?
        }
        :notice => 'Gratulacje! Wiadomo&#347;&#263; zosta&#322;a usuni&#281;ta!'
      end
      redirect_to :back
    end
  end
  
  private
    def set_user
      @user = User.find(params[:user_id])
    end
end
