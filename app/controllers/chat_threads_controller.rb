class ChatThreadsController < ApplicationController

  def new
    @chat_thread = ChatThread.new
    authorize @chat_thread # pundit authorization
  end

  def create
    @chat_thread = Project.new(chat_thread_params)
    authorize @chat_thread # pundit authorization
    if @chat_thread.save
      create_chat_messages(@chat_thread.id)
    else
      render :new
    end

  def create_chat_message(chat_thread_id)
    @chat_message = ChatMessage.new(chat_message_params)
    @chat_message.chat_thread_id = chat_thread_id
    @chat_message.created_at = DateTime.now
    if @chat_message.save
      render :new, notice: "Message sent."
    else
      render :new, notice: "Something went wrong. Message couldn`t be sent. Please try again."
  end


  end

  def destroy

  end

  private

  def chat_thread_params
    params.require(:chat_thread).permit(:user_sender_id, :user_receiver_id, :project_sender_id, :project_receiver_id, :is_user_chat, :is_project_chat, :created_at)
  end

  def chat_message_params
    params.require(:chat_message).permit(:user_id, :content)
  end

end
