class ChatMessagesController < ApplicationController
before_action :verify_authorized

   def new
    @message = ChatMessage.new
    @users = User.all
  end

  def create
    @message = ChatMessage.new(message_params)
    @user_sender = current_user
    @user_receiver = User.find_by(email: receiver_params[:user_receiver])
    @message.user_sender_id = current_user.id
    @message.user_receiver_id = @user_receiver.id
    @message.sent_at = DateTime.now
    if @message.save
      redirect_to profile_path(id: current_user.id), notice: "Your message was sent."
    else
      render :new, notice: "Something went wrong. Your message could not be sent."
    end
  end

  def chat_message_from_card
    respond_to do |format|
      @message = ChatMessage.new
      @participant = Participant.find(params[:participant])
      format.html
      format.js
    end
  end

  def send_chat_message_from_card
    @participant = Participant.find(params[:participant])
    @message = ChatMessage.new(user_sender_id: current_user.id, user_receiver_id: @participant.user.id, sent_at: DateTime.now, content: message_params[:content])
    if @message.save
      redirect_to project_path(@participant.project.id), notice: "Your reply has been sent."
    else
      render :new, notice: 'Something went wrong. Please try again.'
    end
  end

  private

  def verify_authorized
    true
  end

  def message_params
    params.require(:chat_message).permit(:content)
  end

  def receiver_params
    params.require(:other).permit(:user_receiver)
  end

end
