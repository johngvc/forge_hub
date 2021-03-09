class ChatMessagesController < ApplicationController

  def create_message
    @user_sender = current_user
    @user_receiver = User.find(email: params[:user_receiver])
    @message = Message.new(message_params)
    @message.user_sender = @user_sender.id
    @message.sent_at = DateTime.now
    if @message.save
      redirect_to profile_path(id: current_user.id), notice: "Your message was sent."
    else
      render :new, notice: "Something went wrong. Your message could not be sent."
    end
  end

  private

  def message_params
    params.require(:chat_message).permit(:user_receiver, :content, :previous_message_id)
  end
end
