class MessagesController < ApplicationController
  before_action :authorize
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end
  around_action :with_timezone

  def index
    @messages = @conversation.messages.order('created_at ASC')
    @senderr = User.find(@conversation.recipient_id)
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages.order('created_at ASC')
    end
    mark_messages_as_read
    # if @messages.last
    #  if @messages.last.user_id != current_user.id
    #   @messages.last.recipient_read = true;
    #  end
    # end
    @message = @conversation.messages.new
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      user = User.find(@message.user_id)
      ActionCable.server.broadcast "message_channel#{@message.conversation_id}",message_time:@message.message_time,message: @message,conversation:@conversation,user:{id:@message.user_id, avatar:user.avatar, first_name:user.first_name}
      # ActionCable.server.broadcast "message_channel#{@message.conversation_id}",message_time:@message.message_time,message: @message,conversation:@conversation,user:User.find(@message.user_id)

      respond_to do |format|
        format.html {redirect_to conversation_messages_path(@conversation)}
        format.js {render 'index'}
      end
    end
  end


  private
  def message_params
    params.require(:message).permit(:body, :user_id, :conversation_id)
  end


  def mark_messages_as_read
    @messages.each do |message|
      conversation = Conversation.find(message.conversation_id)
      current_user.id == conversation.sender_id ? message.sender_read = true :
          message.recipient_read = true
      message.save
    end
  end


  private

  def with_timezone
    timezone = Time.find_zone(cookies[:timezone])
    unless params[:id].present? && request.path==available_day_path
      Time.use_zone(timezone) { yield }
    else
      yield
    end
  end
end


