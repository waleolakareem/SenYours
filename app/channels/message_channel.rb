class MessageChannel < ApplicationCable::Channel
  def subscribed

    stream_from "message_channel#{params["conversation_id"]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def typing(data)
    ActionCable.server.broadcast "message_channel#{data["conversation_id"]}",data
  end
end
