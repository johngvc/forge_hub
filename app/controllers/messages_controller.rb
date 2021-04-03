class MessagesController < ApplicationController
  before_action :pundit_policy_authorized?

  def create
    @chatroom = Chatroom.find(1)
    @message = Message.new({ content: "Teste 123" })
    @message.chatroom = @chatroom
    @message.user = current_user
    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string(partial: "shared/message", locals: { message: @message })
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
