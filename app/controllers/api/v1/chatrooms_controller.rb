class Api::V1::ChatroomsController < Api::V1::BaseController
  before_action :set_chatroom, only: [:show]

  def index
    @chatrooms = policy_scope(Chatroom)
  end

  def show
  end

  def user_chatrooms
    @user_chatrooms = []
    user = User.find(params[:user_id])
    user.chatrooms.each do |chatroom|
      @user_chatrooms << chatroom
    end
  end

  private

  def set_chatroom
    @response = {}
    messages = []
    chatroom = Chatroom.find(params[:id])
    chatroom.messages.each do |message|
      messages << {
        id: message.id,
        user_name: message.user.name,
        created_at: message.created_at.strftime("%a %b %e at %l:%M%p"),
        content: message.content
      }
    end
    @response[:chatroom] = chatroom
    @response[:messages] = messages
  end
end
