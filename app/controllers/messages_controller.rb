class MessagesController < ApplicationController
  before_action :pundit_policy_authorized?

  def create
    @chatroom = Chatroom.find(params[:activeChatRoomId])
    @message = Message.new({ content: params[:messageContent] })
    @message.chatroom = @chatroom
    @message.user = current_user
    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        {
          message: render_to_string(partial: "shared/message", locals: { message: @message }),
          chatroom_id: params[:activeChatRoomId]
        }
      )
    end
  end

  def pundit_policy_scoped?
    true
  end

  def pundit_policy_authorized?
    true
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
