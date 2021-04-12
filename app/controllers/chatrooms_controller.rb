class ChatroomsController < ApplicationController
  before_action :pundit_policy_authorized?

  def create
    @chatroom = Chatroom.new({
                               name: params[:chatRoomName]
                             })
    if @chatroom.save
      params[:participants_ids].each do |participant_id|
        ChatroomParticipant.create({
                                     user_id: participant_id,
                                     chatroom_id: @chatroom.id
                                   })
      end
    end
  end

  def pundit_policy_scoped?
    true
  end

  def pundit_policy_authorized?
    true
  end

  def message_params
    params.require(:message).permit(:chatRoomName, :participants_ids)
  end
end
