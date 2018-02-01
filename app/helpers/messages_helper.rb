module MessagesHelper
  def get_unread
    if current_user
      @unread = []

      # Grab each conversation for the user and find all messages he hasn't read.
      current_user.conversations.each do |convo|
        if convo.messages.where(sender_read: false).any? && convo.sender_id == current_user.id
          @unread << convo.messages.where(sender_read: false)
        end
        if convo.messages.where(recipient_read: false).any? && convo.recipient_id == current_user.id
          @unread << convo.messages.where(recipient_read: false)
        end
      end
    end
    @unread
  end
end
