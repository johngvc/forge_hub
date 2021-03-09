class ChatMessagesController < ApplicationController
  def create
    @user_sender = current_user
    @message = Message.new(message_params)
    if @message.save
      redirect_to profile_path(id: current_user.id), notice: "Your message was sent."
    else
      render :new, notice: "Something went wrong. Your message could not be sent."
    end
  end


  private

  def message_params
    params.require(:chat_message).permit(:id, :user_receiver, :content)
  end

end
  create_table "chat_messages", force: :cascade do |t|
    t.integer "user_sender_id", null: false
    t.integer "user_receiver_id", null: false
    t.bigint "project_id"
    t.text "content_responding_to"
    t.text "content", null: false
    t.datetime "sent_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_chat_messages_on_project_id"
